Class {
	#name : #GtExtractToTemporaryRefactoring,
	#superclass : #RBExtractToTemporaryRefactoring,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #transforming }
GtExtractToTemporaryRefactoring >> insertTemporary [
	| node statementNode nodeReferences sequenceNode |
	node := self parseTree whichNodeIsContainedBy: sourceInterval.
	(node notNil and: [ node isValue ])
		ifFalse: [ self refactoringFailure: 'Cannot assign to non-value nodes' ].
	statementNode := node statementNode.
	sequenceNode := statementNode parent.
	nodeReferences := (sequenceNode allChildren select: [ :each | each = node ])
			sort: [ :a :b | a start < b start ].
	node := nodeReferences first.
	sequenceNode
		addTemporaryNamed: newVariableName;
		addNode: (self constructAssignmentFrom: node copy) before: node statementNode.
	nodeReferences
		do: [ :each | each replaceWith: (RBVariableNode named: newVariableName) ]
]
