Class {
	#name : #GtCascadesRefactoring,
	#superclass : #RBMethodRefactoring,
	#instVars : [
		'selector'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #transforming }
GtCascadesRefactoring >> extractReceiverIntoVariable: aNode [
	| statement newAssignment oldReceiver variable |
	(aNode parent isAssignment and: [ aNode messages last selector = #yourself ])
		ifTrue: [ statement := aNode statementNode.
			newAssignment := RBAssignmentNode
					variable: aNode parent variable copy
					value: aNode receiver copy.
			oldReceiver := aNode receiver.
			aNode messages
				do: [ :each | each replaceNode: oldReceiver withNode: newAssignment ].
			aNode parent parent replaceNode: aNode parent withNode: aNode ].
	aNode receiver isAssignment
		ifTrue: [ statement := aNode statementNode.
			statement parent addNode: aNode receiver copy before: statement.
			variable := aNode receiver variable.
			aNode messages
				do: [ :each | each replaceNode: aNode receiver withNode: variable ].
			^ aNode ].
	^ self extractTempForReceiver: aNode
]

{ #category : #transforming }
GtCascadesRefactoring >> extractTempForReceiver: aNode [
	| tempName sourceTree |
	tempName := (self options at: #receiverName) value: self.
	self
		performCompositeRefactoring: (GtExtractToTemporaryRefactoring
				model: self model
				extract: aNode receiver sourceInterval
				to: tempName
				from: selector
				in: class).
	sourceTree := class parseTreeForSelector: selector.
	sourceTree
		nodesDo: [ :each | 
			(each isCascade
				and: [ each receiver isVariable
						and: [ each receiver name = tempName
								and: [ each messages size = aNode messages size ] ] ])
				ifTrue: [ ^ each ] ].
	self
		refactoringError: 'Could not find cascaded after extracting temporary variable'
]

{ #category : #private }
GtCascadesRefactoring >> findNode [
	^ self subclassResponsibility
]

{ #category : #preconditions }
GtCascadesRefactoring >> preconditions [
	^ RBCondition definesSelector: selector in: class
]

{ #category : #transforming }
GtCascadesRefactoring >> transform [
	| node |
	node := self findNode.
	node isCascade
		ifFalse: [ ^ self refactoringError: 'Node is not a cascade message send' ].
	node receiver isVariable
		ifFalse: [ node := self extractReceiverIntoVariable: node ].
	self transformNode: node
]

{ #category : #transforming }
GtCascadesRefactoring >> transformNode: aNode [
	self subclassResponsibility
]
