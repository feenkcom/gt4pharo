Class {
	#name : #GtConvertStatementsToCascadesRefactoring,
	#superclass : #RBMethodRefactoring,
	#instVars : [
		'sourceInterval',
		'selector'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #'instance creation' }
GtConvertStatementsToCascadesRefactoring class >> model: model convert: anInterval inMethod: aSelector forClass: aClassOrSelector [
	^ self new
		model: model;
		convert: anInterval
			inMethod: aSelector
			forClass: aClassOrSelector;
		yourself
]

{ #category : #transforming }
GtConvertStatementsToCascadesRefactoring >> basicTransform [
	| nodes cascade |
	nodes := self findNodes.
	nodes size < 2 ifTrue: [ ^ self refactoringError: 'Only one node is selected' ].
	(nodes first isAssignment and: [ nodes first value isMessage ])
		ifTrue: [ cascade := self cascadeWithAssignment: nodes ]
		ifFalse: [ cascade := self cascadeWithoutAssignment: nodes ].
	class compileTree: cascade methodNode
]

{ #category : #accessing }
GtConvertStatementsToCascadesRefactoring >> cascadeWithAssignment: nodes [
	| cascade sends |
	sends := nodes allButFirst.
	self checkAllAreMessageSendsOrCascades: sends.
	self checkAllHaveSameReceiver: sends.
	nodes first variable = nodes last receiver
		ifFalse: [ self refactoringError: 'Variable assigned is not used as the receiver' ].
	sends := Array
			streamContents: [ :str | 
				sends
					do: [ :each | 
						each isMessage ifTrue: [ str nextPut: each ].
						each isCascade ifTrue: [ str nextPutAll: each messages ] ] ].
	cascade := RBCascadeNode
			messages: (sends collect: [ :each | each copy receiver: nodes first value copy ])
					, {RBMessageNode receiver: nodes first value copy selector: #yourself}.
	2 to: nodes size do: [ :i | nodes first parent removeNode: (nodes at: i) ].
	nodes first parent
		replaceNode: nodes first
		withNode: (RBAssignmentNode variable: nodes first variable copy value: cascade).
	^ cascade
]

{ #category : #accessing }
GtConvertStatementsToCascadesRefactoring >> cascadeWithoutAssignment: nodes [
	| cascade messages |
	self checkAllAreMessageSendsOrCascades: nodes.
	self checkAllHaveSameReceiver: nodes.
	nodes first receiver isVariable
		ifTrue: [ self
				refactoringWarning: 'The receiver is not a variable and will only be executed once in a cascade.' ].
	messages := Array
			streamContents: [ :str | 
				nodes
					do: [ :each | 
						each isMessage ifTrue: [ str nextPut: each copy ].
						each isCascade ifTrue: [ str nextPutAll: (each messages collect: #copy) ] ] ].
	cascade := RBCascadeNode messages: messages.
	2 to: nodes size do: [ :i | nodes first parent removeNode: (nodes at: i) ].
	nodes first parent replaceNode: nodes first withNode: cascade.
	^ cascade
]

{ #category : #accessing }
GtConvertStatementsToCascadesRefactoring >> checkAllAreMessageSendsOrCascades: nodes [
	(nodes allSatisfy: [ :each | each isMessage or: [ each isCascade ] ])
		ifFalse: [ self refactoringError: 'All statements are not message sends or cascades' ]
]

{ #category : #accessing }
GtConvertStatementsToCascadesRefactoring >> checkAllHaveSameReceiver: nodes [
	(nodes allSatisfy: [ :each | each receiver = nodes first receiver ])
		ifFalse: [ self refactoringError: 'All messages do not have the same receiver' ]
]

{ #category : #initialization }
GtConvertStatementsToCascadesRefactoring >> convert: anInterval inMethod: aSelector forClass: aClassOrSelector [
	sourceInterval := anInterval.
	selector := aSelector.
	class := self classObjectFor: aClassOrSelector
]

{ #category : #accessing }
GtConvertStatementsToCascadesRefactoring >> findNodes [
	| sourceTree |
	sourceTree := class parseTreeForSelector: selector.
	sourceTree ifNil: [ self refactoringFailure: 'Could not parse source' ].
	sourceTree
		nodesDo: [ :each | 
			each isSequence
				ifTrue: [ (1 to: each statements size)
						detect: [ :i | (each statements at: i) start = sourceInterval first ]
						ifFound: [ :first | 
							(first + 1 to: each statements size)
								detect: [ :i | (each statements at: i) stop = sourceInterval last ]
								ifFound: [ :last | ^ each statements copyFrom: first to: last ] ] ] ].
	^ #()
]

{ #category : #accessing }
GtConvertStatementsToCascadesRefactoring >> gtDescription [
	^ 'Convert statements to cascades'
]

{ #category : #accessing }
GtConvertStatementsToCascadesRefactoring >> preconditions [
	^ RBCondition definesSelector: selector in: class
]

{ #category : #transforming }
GtConvertStatementsToCascadesRefactoring >> privateTranform [
	self basicTransform
]

{ #category : #transforming }
GtConvertStatementsToCascadesRefactoring >> transform [
	self basicTransform
]
