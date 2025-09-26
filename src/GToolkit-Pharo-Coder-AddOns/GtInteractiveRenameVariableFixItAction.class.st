Class {
	#name : #GtInteractiveRenameVariableFixItAction,
	#superclass : #GtFixItVariableNodeAction,
	#instVars : [
		'coderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-FixIt'
}

{ #category : #executing }
GtInteractiveRenameVariableFixItAction >> basicExecuteOn: anEditorElement [
	sourceCoder renameTemporaryIn: coderViewModel node: node
]

{ #category : #accessing }
GtInteractiveRenameVariableFixItAction >> coderViewModel [
	^ coderViewModel
]

{ #category : #accessing }
GtInteractiveRenameVariableFixItAction >> coderViewModel: anObject [
	coderViewModel := anObject
]

{ #category : #'api - action' }
GtInteractiveRenameVariableFixItAction >> description [
	^ 'Rename ' , self nodeName
]

{ #category : #'api - action' }
GtInteractiveRenameVariableFixItAction >> id [
	^ GtInteractiveRenameVariableFixItActionId
]
