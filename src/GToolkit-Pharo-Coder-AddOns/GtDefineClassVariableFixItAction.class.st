Class {
	#name : #GtDefineClassVariableFixItAction,
	#superclass : #GtFixItVariableNodeAction,
	#category : #'GToolkit-Pharo-Coder-AddOns-FixIt'
}

{ #category : #executing }
GtDefineClassVariableFixItAction >> basicExecuteOn: anEditorElement [
	sourceCoder addClassVariable: self nodeName.
	anEditorElement requestFocus
]

{ #category : #accessing }
GtDefineClassVariableFixItAction >> description [
	^ 'Add class variable ' , self nodeName , ' to class ', sourceCoder behavior name
]

{ #category : #accessing }
GtDefineClassVariableFixItAction >> id [
	<return: #BlElementId>

	^ GtDefineClassVariableFixItActionElementId
]
