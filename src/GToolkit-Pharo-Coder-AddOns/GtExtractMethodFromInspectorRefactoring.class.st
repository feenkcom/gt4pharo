"
nil
"
Class {
	#name : #GtExtractMethodFromInspectorRefactoring,
	#superclass : #GtExtractMethodRefactoring,
	#instVars : [
		'source',
		'offset',
		'snippetSelector',
		'snippetMethodSource',
		'snippetSource'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #'instace creation' }
GtExtractMethodFromInspectorRefactoring class >> extract: anInterval from: aString in: aClass [
	^ self new
		extract: anInterval
		from: aString
		in: aClass
]

{ #category : #accessing }
GtExtractMethodFromInspectorRefactoring >> buildNewSnippetSource [
	| ast |
	ast := (class methodFor: snippetSelector) ast body.
	ast temporaryNames do: [ :each | ast removeTemporaryNamed: each ].
	snippetSource := ast formattedCode
]

{ #category : #accessing }
GtExtractMethodFromInspectorRefactoring >> buildSnippetMethod [
	selector := (class compile: self snippetMethodSource classified: #accessing)
			selector
]

{ #category : #accessing }
GtExtractMethodFromInspectorRefactoring >> checkReturn [
	| placeholder |
	super checkReturn.
	placeholder := self placeholderNode.
	needsReturn := placeholder isUsed
			or: [ placeholder parent isSequence
					and: [ placeholder parent statements last == placeholder
							and: [ placeholder parent parent isMethod ] ] ]
]

{ #category : #accessing }
GtExtractMethodFromInspectorRefactoring >> cleanChanges [
	| changesToRemove |
	changesToRemove := model changes changes
			reject: [ :each | (each isKindOf: RBAddMethodChange) and: [ selector ~= each selector ] ].
	changesToRemove do: [ :each | model changes removeChange: each ]
]

{ #category : #accessing }
GtExtractMethodFromInspectorRefactoring >> extract: anInterval from: aString in: aClass [
	class := self classObjectFor: aClass.
	source := aString.
	self buildSnippetMethod.
	extractionInterval := anInterval first + offset to: anInterval last + offset.
	super
		extract: extractionInterval
		from: snippetSelector
		in: aClass
]

{ #category : #accessing }
GtExtractMethodFromInspectorRefactoring >> snippetMethodSource [
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
				and: [ (#('self' 'super' 'thisContext') includes: each variableName) not
						and: [ (Smalltalk globals includesKey: each variableName) not
								and: [ (class definesInstanceVariable: each variableName) not
										and: [ (class bindingOf: each variableName asSymbol) isNil ] ] ] ])
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
GtExtractMethodFromInspectorRefactoring >> snippetSource [
	^ snippetSource
]

{ #category : #accessing }
GtExtractMethodFromInspectorRefactoring >> transform [
	super transform.
	self buildNewSnippetSource.
	self cleanChanges
]
