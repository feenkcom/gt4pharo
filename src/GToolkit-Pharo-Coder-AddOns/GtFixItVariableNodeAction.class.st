Class {
	#name : #GtFixItVariableNodeAction,
	#superclass : #GtFixItAction,
	#category : #'GToolkit-Pharo-Coder-AddOns-FixIt'
}

{ #category : #executing }
GtFixItVariableNodeAction >> finishExecuteOn: anEditorElement [
	self autoSave
		ifTrue: [ BlTaskAction
				enqueueElement: anEditorElement
				action: [ anEditorElement textualCoderViewModel save ] ]
]

{ #category : #'api - node' }
GtFixItVariableNodeAction >> nodeName [
	^ node variableName
]
