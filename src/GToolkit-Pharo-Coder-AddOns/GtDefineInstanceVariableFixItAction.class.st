Class {
	#name : #GtDefineInstanceVariableFixItAction,
	#superclass : #GtFixItVariableNodeAction,
	#category : 'GToolkit-Pharo-Coder-AddOns-FixIt'
}

{ #category : #executing }
GtDefineInstanceVariableFixItAction >> basicExecuteOn: anEditorElement [
	sourceCoder addInstanceVariable: self nodeName.
	BlTaskAction
		enqueueElement: anEditorElement
		action: [ anEditorElement requestFocus ]
]

{ #category : #accessing }
GtDefineInstanceVariableFixItAction >> description [
	^ 'Add slot ' , self nodeName , ' in ', sourceCoder behavior name
]

{ #category : #accessing }
GtDefineInstanceVariableFixItAction >> id [
	<return: #BlElementId>

	^ GtDefineInstanceVariableFixItActionElementId
]
