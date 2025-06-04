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
	| ast newSource location declaration statementNode sequenceNode varNode |
	ast := sourceCoder rbAST.
	newSource := sourceCoder currentSourceString.
	varNode := ast nodeForOffset: node startPosition.
	statementNode := varNode statementNode.
	sequenceNode := statementNode parent.
	sequenceNode hasTemporaries
		ifTrue: [ location := sequenceNode rightBar position - 1.
			declaration := ((newSource at: location) isSeparator
					ifTrue: [ '' ]
					ifFalse: [ ' ' ]) , self nodeName , ' ' ]
		ifFalse: [ location := sequenceNode start - 1.
			declaration := '| ' , self nodeName , ' |' , String cr , String tab ].
	newSource := (newSource first: location) , declaration
			, (newSource allButFirst: location).
	sourceCoder currentSourceString: newSource
]

{ #category : #accessing }
GtDefineTemporaryFixItAction >> id [
	<return: #BlElementId>

	^ GtDefineTemporaryVariableFixItActionElementId
]
