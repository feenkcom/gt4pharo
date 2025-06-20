Class {
	#name : #GtMoveTemporaryToOuterScopeRefactoring,
	#superclass : #RBMethodRefactoring,
	#instVars : [
		'selector',
		'interval',
		'variableNode'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Variables'
}

{ #category : #examples }
GtMoveTemporaryToOuterScopeRefactoring class >> doesRefactoringRun: aRefactoring [
	^ [ aRefactoring primitiveExecute.
	true ] on: RBRefactoringError do: [ :ex | ex return: false ]
]

{ #category : #examples }
GtMoveTemporaryToOuterScopeRefactoring class >> dummyIntervalForVariable: aString [
	| source index |
	source := self class sourceCodeAt: #dummyMethod:.
	index := source indexOfSubCollection: aString.
	^ index to: index + aString size - 1
]

{ #category : #examples }
GtMoveTemporaryToOuterScopeRefactoring class >> dummyMethod: arg [
	| outer |
	outer := self printString.
	outer size > 10
		ifTrue: [ | blockVar |
			blockVar := 3.
			outer := outer , blockVar printString ]
		ifFalse: [ | good |
			good := 4.
			outer := outer , good printString ].
	outer
		do: [ :blockVar | 
			Transcript
				print: blockVar;
				cr;
				flush ]
]

{ #category : #examples }
GtMoveTemporaryToOuterScopeRefactoring class >> methodArgumentSelectedExample [
	<gtExample>
	| refactoring |
	refactoring := self
			moveVariableAt: (self dummyIntervalForVariable: 'arg')
			in: #dummyMethod:
			class: self class.
	self assert: (self doesRefactoringRun: refactoring) equals: false.
	^ refactoring
]

{ #category : #'instance creation' }
GtMoveTemporaryToOuterScopeRefactoring class >> model: aModel moveVariableAt: anInterval in: aSelector class: aClass [
	^ self new
		model: aModel;
		moveVariableAt: anInterval
			in: aSelector
			class: aClass
]

{ #category : #examples }
GtMoveTemporaryToOuterScopeRefactoring class >> moveToOuterScopeExample [
	<gtExample>
	| refactoring newSource |
	newSource := self class sourceCodeAt: #dummyMethod:.
	newSource := (newSource copyReplaceAll: '| outer |' with: '| outer good |')
			copyReplaceAll: '| good |'
			with: ''.
	refactoring := self
			moveVariableAt: (self dummyIntervalForVariable: 'good')
			in: #dummyMethod:
			class: self class.
	self assert: (self doesRefactoringRun: refactoring) equals: true.
	self
		assert: ((refactoring model classFor: self class) parseTreeForSelector: #dummyMethod:)
		equals: (RBParser parseMethod: newSource).
	^ refactoring model
]

{ #category : #'instance creation' }
GtMoveTemporaryToOuterScopeRefactoring class >> moveVariableAt: anInterval in: aSelector class: aClass [
	^ self new
		moveVariableAt: anInterval
		in: aSelector
		class: aClass
]

{ #category : #examples }
GtMoveTemporaryToOuterScopeRefactoring class >> outerTempSelectedExample [
	<gtExample>
	| refactoring |
	refactoring := self
			moveVariableAt: (self dummyIntervalForVariable: 'outer')
			in: #dummyMethod:
			class: self class.
	self assert: (self doesRefactoringRun: refactoring) equals: false.
	^ refactoring
]

{ #category : #examples }
GtMoveTemporaryToOuterScopeRefactoring class >> selfExample [
	<gtExample>
	| refactoring |
	refactoring := self
			moveVariableAt: (self dummyIntervalForVariable: 'self')
			in: #dummyMethod:
			class: self class.
	self assert: (self doesRefactoringRun: refactoring) equals: false.
	^ refactoring
]

{ #category : #examples }
GtMoveTemporaryToOuterScopeRefactoring class >> tempIsAlsoBlockVarExample [
	<gtExample>
	| refactoring |
	refactoring := self
			moveVariableAt: (self dummyIntervalForVariable: 'blockVar')
			in: #dummyMethod:
			class: self class.
	self assert: (self doesRefactoringRun: refactoring) equals: false.
	^ refactoring
]

{ #category : #transforming }
GtMoveTemporaryToOuterScopeRefactoring >> basicTransform [
	| definers definer newDefiner name |
	name := self variableNode name.
	definer := self variableNode parent.
	newDefiner := definer allParents detect: [ :each | each isSequence ].
	definers := IdentitySet with: definer.
	self variableNode methodNode
		nodesDo: [ :each | 
			(each isVariable and: [ each name = name ])
				ifTrue: [ (each whoDefines: name)
						ifNil: [ self
								refactoringError: 'Cannot move variable scope as it would change other references' ]
						ifNotNil: [ :node | 
							node isBlock
								ifTrue: [ self
										refactoringError: 'Cannot move variable scope as a block in that scope uses it as an argument.' ].
							definers add: node ] ] ].
	definers := definers select: [ :each | each allParents includes: newDefiner ].
	definers do: [ :each | each removeTemporaryNamed: name ].
	newDefiner addTemporaryNamed: name.
	(class methodFor: selector) compileTree: newDefiner methodNode
]

{ #category : #initialization }
GtMoveTemporaryToOuterScopeRefactoring >> moveVariableAt: anInterval in: aSelector class: aClass [
	interval := anInterval.
	selector := aSelector.
	class := self model classFor: aClass
]

{ #category : #preconditions }
GtMoveTemporaryToOuterScopeRefactoring >> preconditions [
	^ (RBCondition definesSelector: selector in: class)
		& (RBCondition
				withBlock: [ self variableNode notNil
						and: [ self variableNode parent isSequence
								and: [ self variableNode parent temporaries identityIncludes: self variableNode ] ] ]
				errorString: 'Selection is not a variable declaration')
		& (RBCondition
				withBlock: [ self variableNode parent parent isMethod not ]
				errorString: 'Variable is already at outermost scope')
]

{ #category : #transforming }
GtMoveTemporaryToOuterScopeRefactoring >> privateTransform [
	self basicTransform
]

{ #category : #transforming }
GtMoveTemporaryToOuterScopeRefactoring >> transform [
	self basicTransform
]

{ #category : #private }
GtMoveTemporaryToOuterScopeRefactoring >> variableNode [
	^ variableNode
		ifNil: [ | ast |
			ast := class parseTreeForSelector: selector.
			ast
				nodesDo: [ :each | 
					(each isVariable and: [ each sourceInterval = interval ])
						ifTrue: [ variableNode := each ] ].
			variableNode ]
]
