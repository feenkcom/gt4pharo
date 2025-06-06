Class {
	#name : #GtDefineTemporaryFixItAction,
	#superclass : #GtFixItVariableNodeAction,
	#category : #'GToolkit-Pharo-Coder-AddOns-FixIt'
}

{ #category : #accessing }
GtDefineTemporaryFixItAction >> description [
	^ 'Add temporary variable ' , self nodeName
]

{ #category : #executing }
GtDefineTemporaryFixItAction >> executeOn: anEditorElement [
	| ast newSource sequenceNode varNode nodeReferences bestNode |
	ast := sourceCoder rbAST.
	newSource := sourceCoder currentSourceString.
	varNode := ast nodeForOffset: node startPosition.
	nodeReferences := (ast allChildren select: [ :each | each = varNode ])
			sort: [ :a :b | a start < b start ].
	bestNode := ast
			bestNodeFor: (nodeReferences first start to: nodeReferences last stop).
	sequenceNode := bestNode isSequence
			ifTrue: [ bestNode ]
			ifFalse: [ bestNode statementNode parent ].

	sequenceNode addTemporaryNamed: node value.
	newSource := ast newSource.
	sourceCoder currentSourceString: newSource
]

{ #category : #accessing }
GtDefineTemporaryFixItAction >> id [
	<return: #BlElementId>

	^ GtDefineTemporaryVariableFixItActionElementId
]
