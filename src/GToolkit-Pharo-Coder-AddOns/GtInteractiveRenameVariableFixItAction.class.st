Class {
	#name : #GtInteractiveRenameVariableFixItAction,
	#superclass : #GtFixItVariableNodeAction,
	#instVars : [
		'coderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-FixIt'
}

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

{ #category : #executing }
GtInteractiveRenameVariableFixItAction >> executeOn: anEditorElement [
	sourceCoder renameTemporaryIn: coderViewModel node: node
]

{ #category : #'api - action' }
GtInteractiveRenameVariableFixItAction >> id [
	^ GtInteractiveRenameVariableFixItActionId
]
