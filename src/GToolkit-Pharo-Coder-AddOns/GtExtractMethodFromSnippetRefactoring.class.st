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
		'movedSelector',
		'returnPosition'
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
	returnPosition
		ifNotNil: [ (ast isSequence and: [ ast statements last isReturn ])
				ifTrue: [ ast statements last replaceWith: ast statements last value copy ] ].
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
			reject: [ :each | self shouldKeepChange: each ].
	changesToRemove do: [ :each | model changes removeChange: each ]
]

{ #category : #'initialize-release' }
GtExtractMethodFromSnippetRefactoring >> extract: anInterval from: aString [
	source := aString.
	self buildSnippetMethod.
	extractionInterval := anInterval first + offset
			+ ((returnPosition notNil and: [ anInterval first >= returnPosition ])
					ifTrue: [ 1 ]
					ifFalse: [ 0 ])
			to: anInterval last + offset
					+ ((returnPosition notNil and: [ anInterval last >= returnPosition ])
							ifTrue: [ 1 ]
							ifFalse: [ 0 ])
]

{ #category : #accessing }
GtExtractMethodFromSnippetRefactoring >> gtDescription [
	^ 'Extract method from snippet'
]

{ #category : #transforming }
GtExtractMethodFromSnippetRefactoring >> inlineForwarder [
	| refactoring |
	refactoring := GtInlineMethodRefactoring
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

{ #category : #transforming }
GtExtractMethodFromSnippetRefactoring >> privateTransform [
	super privateTransform.
	self buildNewSnippetSource.
	self cleanChanges
]

{ #category : #testing }
GtExtractMethodFromSnippetRefactoring >> shouldKeepChange: aRBChangeObject [
	^ (aRBChangeObject isKindOf: RBAddMethodChange)
		and: [ movedSelector = aRBChangeObject selector
				and: [ moveToClasses
						anySatisfy: [ :cls | cls realClass = aRBChangeObject changeClass ] ] ]
]

{ #category : #private }
GtExtractMethodFromSnippetRefactoring >> snippetMethodSource [
	| ast expressionAST |
	snippetMethodSource notNil ifTrue: [ ^ snippetMethodSource ].
	snippetMethodSource := self snippetMethodSourceFrom: source.
	ast := GtPharoParser parse: snippetMethodSource.
	expressionAST := GtPharoParser
			parse: source
			startingAt: GtPharoParser startingStateForMethodSequence.
	offset := ast body statements first startPosition
			- expressionAST statements first startPosition.
	snippetMethodSource first = $ 
		ifTrue: [ returnPosition := ast body statements last upArrow startPosition - offset ].
	snippetSelector := ast selector.
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
