Class {
	#name : #GtDefineInstanceVariableFixItAction,
	#superclass : #GtFixItVariableNodeAction,
	#category : #'GToolkit-Pharo-Coder-AddOns-FixIt'
}

{ #category : #executing }
GtDefineInstanceVariableFixItAction >> basicExecuteOn: anEditorElement [
	BlTaskAction enqueueElement: self action: [
		sourceCoder addInstanceVariable: self nodeName.
		anEditorElement requestFocus ]
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
