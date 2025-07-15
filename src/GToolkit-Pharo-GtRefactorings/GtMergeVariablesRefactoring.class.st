Class {
	#name : #GtMergeVariablesRefactoring,
	#superclass : #RBMethodRefactoring,
	#instVars : [
		'selector',
		'fromInterval',
		'toInterval',
		'ast',
		'fromNode',
		'toNode',
		'aliasVariable',
		'isArgVariable'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #'instance creation' }
GtMergeVariablesRefactoring class >> mergeVariableFrom: fromInterval into: toInterval from: aSelector in: aClass [
	^ self new
		class: aClass;
		selector: aSelector;
		fromInterval: fromInterval;
		toInterval: toInterval;
		yourself
]

{ #category : #'instance creation' }
GtMergeVariablesRefactoring class >> model: aModel mergeVariableFrom: fromInterval into: toInterval from: aSelector in: aClass [
	^ self new
		model: aModel;
		class: aClass;
		selector: aSelector;
		fromInterval: fromInterval;
		toInterval: toInterval;
		yourself
]

{ #category : #preconditions }
GtMergeVariablesRefactoring >> assignmentsFor: aNode [
	| assignments |
	assignments := IdentitySet new.
	(aNode whoDefines: aNode name)
		nodesDo: [ :each | 
			(each isAssignment and: [ each variable = aNode ])
				ifTrue: [ assignments add: each ] ].
	^ assignments
]

{ #category : #accessing }
GtMergeVariablesRefactoring >> ast [
	^ ast ifNil: [ ast := class parseTreeForSelector: selector ]
]

{ #category : #transforming }
GtMergeVariablesRefactoring >> basicTransform [
	| source definer toDefiner var |
	source := SmaCCString on: self ast source.
	definer := self fromNode whoDefines: self fromNode name.
	isArgVariable
		ifTrue: [ toDefiner := self toNode whoDefines: self toNode name.
			toDefiner isSequence
				ifTrue: [ var := toDefiner temporaries detect: [ :each | each = self toNode ].
					source deleteFrom: var start to: var stop.
					source deleteWhitespaceAfterIndex: var start ] ].
	self ast
		nodesDo: [ :each | 
			each = self fromNode
				ifTrue: [ (each whoDefines: each name) == definer
						ifTrue: [ (each parent == definer and: [ definer temporaries identityIncludes: each ])
								ifTrue: [ source deleteFrom: each start to: each stop.
									source deleteWhitespaceAfterIndex: each start ]
								ifFalse: [ (each parent isAssignment
										and: [ each parent variable = self toNode or: [ each parent value = self toNode ] ])
										ifTrue: [ each parent isUsed
												ifTrue: [ source
														replaceFrom: each parent start
														to: each parent stop
														with: self toNode name ]
												ifFalse: [ source deleteFrom: each parent start to: each parent stop.
													each parent parent periods
														detect: [ :p | p > each start ]
														ifFound: [ :p | source deleteFrom: p to: p ].
													source deleteWhitespaceAfterIndex: each start ] ]
										ifFalse: [ source
												replaceFrom: each start
												to: each stop
												with: self toNode name ] ] ] ] ].
	class compile: source asString
]

{ #category : #preconditions }
GtMergeVariablesRefactoring >> checkAssignments [
	| fromAssignments toAssignments |
	fromAssignments := self fromAssignments.
	toAssignments := self toAssignments.
	(fromAssignments size = 1 and: [ fromAssignments any value = self toNode ])
		ifTrue: [ (toAssignments allSatisfy: [ :each | each stop < fromAssignments any start ])
				ifFalse: [ self refactoringError: self toNode name , ' assigned after aliased' ].
			self checkAssignments: toAssignments areSameScopeOf: fromAssignments any.
			^ aliasVariable := self fromNode ].
	(toAssignments size = 1 and: [ toAssignments any value = self fromNode ])
		ifTrue: [ (fromAssignments allSatisfy: [ :each | each stop < toAssignments any start ])
				ifFalse: [ self refactoringError: self fromNode name , ' assigned after aliased' ].
			self checkAssignments: fromAssignments areSameScopeOf: toAssignments any.
			^ aliasVariable := self toNode ].
	self
		refactoringError: 'Cannot merge variables if not assigned single time to aliased variable'
]

{ #category : #preconditions }
GtMergeVariablesRefactoring >> checkAssignments: assignments areSameScopeOf: aliasAssignment [
	| aliasSequenceParents |
	aliasSequenceParents := aliasAssignment allParents select: #isSequence.
	assignments
		do: [ :each | 
			| current |
			current := each.
			[ current notNil
				and: [ (aliasSequenceParents identityIncludes: current) not ] ]
				whileTrue: [ (current isBlock and: [ current isInlined not ])
						ifTrue: [ self refactoringWarning: each variable name , ' is assigned in a block' ].
					current := current parent ] ]
]

{ #category : #preconditions }
GtMergeVariablesRefactoring >> checkReadersWithinScope [
	| assignment readers |
	assignment := (self assignmentsFor: aliasVariable) any.
	readers := self readersFor: aliasVariable.
	readers
		do: [ :each | 
			each start < assignment stop
				ifTrue: [ self refactoringError: aliasVariable name , ' is read before written' ].
			(each allParents identityIncludes: assignment parent)
				ifFalse: [ self
						refactoringError: aliasVariable name , ' is read in a scope where it was not assigned' ] ]
]

{ #category : #preconditions }
GtMergeVariablesRefactoring >> checkSameScope [
	| fromDefiner toDefiner |
	isArgVariable := false.
	fromDefiner := self fromNode whoDefines: self fromNode name.
	toDefiner := self toNode whoDefines: self toNode name.
	(fromDefiner isNil or: [ toDefiner isNil ])
		ifTrue: [ self refactoringError: 'Can only merge temporary variables' ].
	fromDefiner == toDefiner ifTrue: [ ^ self ].
	(fromDefiner isMethod or: [ toDefiner isMethod ])
		ifTrue: [ isArgVariable := true.
			^ self ].
	fromDefiner isBlock
		ifTrue: [ isArgVariable := true.
			(toDefiner allParents identityIncludes: fromDefiner) ifTrue: [ ^ self ].
			self refactoringError: 'Block variable has shorter lifetime than temporary' ].
	toDefiner isBlock
		ifTrue: [ isArgVariable := true.
			(fromDefiner allParents identityIncludes: toDefiner) ifTrue: [ ^ self ].
			self refactoringError: 'Block variable has shorter lifetime than temporary' ].
	self refactoringError: 'Cannot merge variables at different scopes'
]

{ #category : #initialization }
GtMergeVariablesRefactoring >> class: aClass [
	class := self classObjectFor: aClass
]

{ #category : #preconditions }
GtMergeVariablesRefactoring >> fromAssignments [
	^ self assignmentsFor: self fromNode
]

{ #category : #initialization }
GtMergeVariablesRefactoring >> fromInterval: anInterval [
	fromInterval := anInterval
]

{ #category : #accessing }
GtMergeVariablesRefactoring >> fromNode [
	^ fromNode
		ifNil: [ self ast
				nodesDo: [ :each | 
					(each isVariable and: [ each sourceInterval = fromInterval ])
						ifTrue: [ fromNode := each ] ].
			fromNode ]
]

{ #category : #preconditions }
GtMergeVariablesRefactoring >> preconditions [
	^ (RBCondition definesSelector: selector in: class)
		& (RBCondition
				withBlock: [ self verifyVariables.
					true ])
]

{ #category : #transforming }
GtMergeVariablesRefactoring >> privateTransform [
	self basicTransform
]

{ #category : #preconditions }
GtMergeVariablesRefactoring >> readersFor: aVariable [
	| readers definer |
	readers := OrderedCollection new.
	(definer := aVariable whoDefines: aVariable name) statements
		do: [ :stmt | 
			stmt
				nodesDo: [ :each | 
					(each isVariable and: [ each = aliasVariable ])
						ifTrue: [ (each parent isAssignment and: [ each parent variable == each ])
								ifFalse: [ readers add: each ] ] ] ].
	^ readers
]

{ #category : #initialization }
GtMergeVariablesRefactoring >> selector: aSelector [
	selector := aSelector
]

{ #category : #preconditions }
GtMergeVariablesRefactoring >> toAssignments [
	^ self assignmentsFor: self toNode
]

{ #category : #initialization }
GtMergeVariablesRefactoring >> toInterval: anInterval [
	toInterval := anInterval
]

{ #category : #accessing }
GtMergeVariablesRefactoring >> toNode [
	^ toNode
		ifNil: [ self ast
				nodesDo: [ :each | 
					(each isVariable and: [ each sourceInterval = toInterval ])
						ifTrue: [ toNode := each ] ].
			toNode ]
]

{ #category : #transforming }
GtMergeVariablesRefactoring >> transform [
	self basicTransform
]

{ #category : #preconditions }
GtMergeVariablesRefactoring >> verifyVariables [
	self fromNode ifNil: [self refactoringError: 'Invalid from variable'].
	self toNode ifNil: [self refactoringError: 'Invalid to variable'].
	self checkSameScope.
	self checkAssignments.
	self checkReadersWithinScope
]
