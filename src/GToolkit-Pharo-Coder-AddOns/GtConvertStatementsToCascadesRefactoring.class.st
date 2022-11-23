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

{ #category : #initialization }
GtConvertStatementsToCascadesRefactoring >> convert: anInterval inMethod: aSelector forClass: aClassOrSelector [
	sourceInterval := anInterval.
	selector := aSelector.
	class := self classObjectFor: aClassOrSelector
]

{ #category : #accessing }
GtConvertStatementsToCascadesRefactoring >> findNodes [
	| sourceTree |
	sourceTree := class parseTreeFor: selector.
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
GtConvertStatementsToCascadesRefactoring >> preconditions [
	^ RBCondition definesSelector: selector in: class
]

{ #category : #accessing }
GtConvertStatementsToCascadesRefactoring >> transform [
	| nodes cascade |
	nodes := self findNodes.
	nodes size < 2 ifTrue: [ ^ self refactoringError: 'Only one node is selected' ].
	(nodes allSatisfy: [ :each | each isMessage ])
		ifFalse: [ ^ self refactoringError: 'All statements are not message sends' ].
	(nodes allSatisfy: [ :each | each receiver = nodes first receiver ])
		ifFalse: [ ^ self refactoringError: 'All messages do not have the same receiver' ].
	nodes first receiver isVariable
		ifTrue: [ self
				refactoringWarning: 'The receiver is not a variable and will only be executed once in a cascade.' ].
	cascade := RBCascadeNode messages: (nodes collect: [ :each | each copy ]).
	2 to: nodes size do: [ :i | nodes first parent removeNode: (nodes at: i) ].
	nodes first parent replaceNode: nodes first withNode: cascade.
	class compileTree: cascade methodNode
]
