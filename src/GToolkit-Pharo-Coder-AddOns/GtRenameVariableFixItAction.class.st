Class {
	#name : #GtRenameVariableFixItAction,
	#superclass : #GtFixItVariableNodeAction,
	#instVars : [
		'newName'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-FixIt'
}

{ #category : #executing }
GtRenameVariableFixItAction >> basicExecuteOn: anEditorElement [
	| newSource |
	newSource := sourceCoder currentSourceString.
	newSource := (newSource first: self startPosition - 1) , newName
			, (newSource allButFirst: self stopPosition).
	sourceCoder currentSourceString: newSource.
	BlTaskAction
		enqueueElement: anEditorElement
		action: [ anEditorElement requestFocus ]
]

{ #category : #accessing }
GtRenameVariableFixItAction >> description [
	^ 'Use ' , newName , ' instead of ' , self nodeName
]

{ #category : #accessing }
GtRenameVariableFixItAction >> id [
	<return: #BlElementId>

	^ GtRenameVariableFixItActionElementId
]

{ #category : #initialization }
GtRenameVariableFixItAction >> newName: aString [
	newName := aString
]
