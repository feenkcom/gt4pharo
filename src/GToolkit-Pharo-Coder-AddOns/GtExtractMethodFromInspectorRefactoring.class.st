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
		'snippetSource',
		'originalInterval',
		'returnPosition'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Extract method'
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
	returnPosition
		ifNotNil: [ (ast isSequence and: [ ast statements last isReturn ])
				ifTrue: [ ast statements last replaceWith: ast statements last value copy ] ].
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
			reject: [ :each | self shouldKeepChange: each ].
	changesToRemove do: [ :each | model changes removeChange: each ]
]

{ #category : #accessing }
GtExtractMethodFromInspectorRefactoring >> extract: anInterval from: aString in: aClass [
	class := self classObjectFor: aClass.
	source := aString.
	originalInterval := anInterval
]

{ #category : #accessing }
GtExtractMethodFromInspectorRefactoring >> gtDescription [
	^ 'Extract method from snippet'
]

{ #category : #accessing }
GtExtractMethodFromInspectorRefactoring >> preconditions [
	self buildSnippetMethod.
	extractionInterval := originalInterval first + offset
			+ ((returnPosition notNil and: [ originalInterval first >= returnPosition ])
					ifTrue: [ 1 ]
					ifFalse: [ 0 ])
			to: originalInterval last + offset
					+ ((returnPosition notNil and: [ originalInterval last >= returnPosition ])
							ifTrue: [ 1 ]
							ifFalse: [ 0 ]).
	selector := snippetSelector.
	^ super preconditions
]

{ #category : #transforming }
GtExtractMethodFromInspectorRefactoring >> privateTransform [
	super privateTransform.
	self buildNewSnippetSource.
	self cleanChanges
]

{ #category : #accessing }
GtExtractMethodFromInspectorRefactoring >> shouldKeepChange: each [
	^ (each isKindOf: RBAddMethodChange) and: [ selector ~= each selector ]
]

{ #category : #accessing }
GtExtractMethodFromInspectorRefactoring >> snippetMethodSource [
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
GtExtractMethodFromInspectorRefactoring >> snippetSource [
	^ snippetSource
]

{ #category : #accessing }
GtExtractMethodFromInspectorRefactoring >> transform [
	super transform.
	self buildNewSnippetSource.
	self cleanChanges
]
