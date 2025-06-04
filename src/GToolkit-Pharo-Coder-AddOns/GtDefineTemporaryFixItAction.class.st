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
	| ast newSource statementNode sequenceNode varNode |
	ast := sourceCoder rbAST.
	newSource := sourceCoder currentSourceString.
	varNode := ast nodeForOffset: node startPosition.
	statementNode := varNode statementNode.
	sequenceNode := statementNode parent.
	sequenceNode addTemporaryNamed: node value.
	newSource := ast newSource.
	sourceCoder currentSourceString: newSource
]

{ #category : #accessing }
GtDefineTemporaryFixItAction >> id [
	<return: #BlElementId>

	^ GtDefineTemporaryVariableFixItActionElementId
]
