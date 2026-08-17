Class {
	#name : #GtInteractiveRenameVariableFixItAction,
	#superclass : #GtFixItVariableNodeAction,
	#instVars : [
		'coderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-FixIt'
}

{ #category : #actions }
GtInteractiveRenameVariableFixItAction >> basicExecuteOn: anEditorElement [
	BlTaskAction enqueueElement: anEditorElement action: [
		sourceCoder
			renameTemporaryIn: coderViewModel
			node: node
			context: (GtCoderAddOnsBuildContext new
				documentId: coderViewModel documentId;
				astNode: node;
				editorElement: anEditorElement;
				sourceCoderViewModel: coderViewModel) ]
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
