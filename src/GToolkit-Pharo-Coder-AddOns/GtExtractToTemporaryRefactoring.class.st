Class {
	#name : #GtExtractToTemporaryRefactoring,
	#superclass : #RBExtractToTemporaryRefactoring,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring'
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
	[ nodeReferences first statementNode parent ~= sequenceNode ]
		whileTrue: [ nodeReferences removeFirst ].
	node := nodeReferences first.
	sequenceNode addTemporaryNamed: newVariableName.
	(node isVariable and: [ node isWrite ])
		ifFalse: [ sequenceNode
				addNode: (self constructAssignmentFrom: node copy)
				before: node statementNode ].
	nodeReferences
		do: [ :each | 
			(each isVariable and: [ each isWrite ])
				ifTrue: [ each statementNode parent addNode: each parent copy before: each statementNode.
					each parent
						replaceWith: (RBAssignmentNode
								variable: (RBVariableNode named: newVariableName)
								value: each copy) ]
				ifFalse: [ each replaceWith: (RBVariableNode named: newVariableName) ] ]
]
