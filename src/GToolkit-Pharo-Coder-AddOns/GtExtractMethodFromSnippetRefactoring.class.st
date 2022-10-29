"
nil
"
Class {
	#name : #GtExtractMethodFromSnippetRefactoring,
	#superclass : #GtExtractMethodToComponentRefactoring,
	#instVars : [
		'source',
		'offset',
		'snippetSource',
		'snippetMethodSource',
		'snippetSelector',
		'moveToClasses',
		'movedSelector'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #'instance creation' }
GtExtractMethodFromSnippetRefactoring class >> extract: anInterval from: aString [
	^ self new extract: anInterval from: aString
]

{ #category : #transforming }
GtExtractMethodFromSnippetRefactoring >> buildNewSnippetSource [
	| ast |
	ast := ((model classFor: nil class) methodFor: snippetSelector) ast body.
	ast temporaryNames do: [ :each | ast removeTemporaryNamed: each ].
	snippetSource := ast formattedCode
]

{ #category : #private }
GtExtractMethodFromSnippetRefactoring >> buildSnippetMethod [
	class := self classObjectFor: nil class.
	selector := (class compile: self snippetMethodSource classified: #accessing) selector
]

{ #category : #transforming }
GtExtractMethodFromSnippetRefactoring >> cleanChanges [
	| changesToRemove |
	changesToRemove := model changes changes
		reject:
			[ :each | 
			(each isKindOf: RBAddMethodChange)
				and: [ movedSelector = each selector and: [ moveToClasses anySatisfy: [ :cls | cls realClass = each changeClass ] ] ] ].
	changesToRemove do: [ :each | model changes removeChange: each ]
]

{ #category : #'initialize-release' }
GtExtractMethodFromSnippetRefactoring >> extract: anInterval from: aString [
	source := aString.
	self buildSnippetMethod.
	extractionInterval := anInterval first + offset to: anInterval last + offset
]

{ #category : #transforming }
GtExtractMethodFromSnippetRefactoring >> inlineForwarder [
	| refactoring |
	refactoring := RBInlineMethodRefactoring
		model: self model
		inline: self inlineInterval
		inMethod: snippetSelector
		forClass: (model classFor: nil class).
	refactoring setOption: #inlineExpression toUse: [ :ref :string | true ].
	self performCompositeRefactoring: refactoring
]

{ #category : #transforming }
GtExtractMethodFromSnippetRefactoring >> inlineInterval [
	((model classFor: nil class) methodFor: snippetSelector) ast
		nodesDo:
			[ :each | (each isMessage and: [ each selector = extractedMethodSelector ]) ifTrue: [ ^ each start to: each stop ] ].
	^ nil
]

{ #category : #transforming }
GtExtractMethodFromSnippetRefactoring >> moveMethod [
	| variable refactoring |
	variable := self selectVariableToMoveMethodTo: extractedMethodSelector class: class.
	variable ifNil: [ self refactoringFailure: 'Did not extract method' ].
	refactoring := GtMoveMethodRefactoring
		model: self model
		selector: extractedMethodSelector
		class: class
		variable: variable.
	self performCompositeRefactoring: refactoring.
	moveToClasses := refactoring moveToClasses.
	movedSelector := refactoring movedSelector
]

{ #category : #private }
GtExtractMethodFromSnippetRefactoring >> snippetMethodSource [
	| ast newSource temps written methodPattern tempsSource |
	snippetMethodSource notNil ifTrue: [ ^ snippetMethodSource ].
	temps := Set new.
	newSource := SmaCCString on: source.
	ast := GtPharoParser
			parse: source
			startingAt: GtPharoParser startingStateForMethodSequence.
	ast
		allNodesOfType: GtPharoVariableNode
		do: [ :each | 
			(each whoDefines isNil
				and: [ (#(self super) includes: each variableName) not
						and: [ (Smalltalk globals includesKey: each variableName) not ] ])
				ifTrue: [ temps add: each ] ].
	written := Set new.
	ast
		allNodesOfType: GtPharoAssignmentNode
		do: [ :each | 
			(temps includes: each variable)
				ifTrue: [ written add: each variable.
					temps remove: each variable ] ].
	methodPattern := temps isEmpty
			ifTrue: [ '__ ' ]
			ifFalse: [ String
					streamContents: [ :stream | 
						temps
							do: [ :each | 
								stream
									nextPutAll: '__: ';
									nextPutAll: each variableName;
									space ] ] ].
	newSource insert: methodPattern at: 1.
	offset := methodPattern size.
	written notEmpty
		ifTrue: [ tempsSource := String
					streamContents: [ :stream | 
						ast leftBar ifNil: [ stream nextPut: $| ].
						written
							do: [ :each | 
								stream
									space;
									nextPutAll: each variableName ].
						ast leftBar ifNil: [ stream nextPut: $| ] ].
			newSource
				insert: tempsSource
				at: (ast rightBar ifNil: [ 1 ] ifNotNil: [ :token | token startPosition ]).
			offset := offset + tempsSource size ].
	snippetMethodSource := newSource asString.
	snippetSelector := (GtPharoParser parse: snippetMethodSource) selector.
	^ snippetMethodSource
]

{ #category : #accessing }
GtExtractMethodFromSnippetRefactoring >> snippetSource [
	^ snippetSource
]

{ #category : #transforming }
GtExtractMethodFromSnippetRefactoring >> transform [
	super transform.
	self buildNewSnippetSource.
	self cleanChanges
]
