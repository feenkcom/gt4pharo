Class {
	#name : #GtDefineTemporaryFixItAction,
	#superclass : #GtFixItVariableNodeAction,
	#category : #'GToolkit-Pharo-Coder-AddOns-FixIt'
}

{ #category : #executing }
GtDefineTemporaryFixItAction >> addDefinitionForTempAtOffset: anInteger in: ast [
	| bestNode varNode nodeReferences sequenceNode source |
	source := SmaCCString on: ast methodNode source.
	varNode := ast nodeForOffset: anInteger.
	nodeReferences := (ast allChildren select: [ :each | each = varNode ])
			sort: [ :a :b | a start < b start ].
	bestNode := ast
			bestNodeFor: (nodeReferences first start to: nodeReferences last stop).
	sequenceNode := bestNode isSequence
			ifTrue: [ bestNode ]
			ifFalse: [ bestNode statementNode parent ].

	sequenceNode gtAddTemporaryNamed: varNode name toSource: source.
	^ source asString
]

{ #category : #executing }
GtDefineTemporaryFixItAction >> basicExecuteOn: anEditorElement [
	| ast variableNode source |
	ast := sourceCoder rbAST.
	variableNode := node.
	source := self addDefinitionForTempAtOffset: variableNode startPosition in: ast.
	sourceCoder currentSourceString: source.
	BlTaskAction
		enqueueElement: anEditorElement
		action: [ anEditorElement requestFocus ]
]

{ #category : #accessing }
GtDefineTemporaryFixItAction >> description [
	^ 'Add temporary variable ' , self nodeName
]

{ #category : #accessing }
GtDefineTemporaryFixItAction >> id [
	<return: #BlElementId>

	^ GtDefineTemporaryVariableFixItActionElementId
]
