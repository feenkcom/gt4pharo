Class {
	#name : #GtRemoveMethodFixItAction,
	#superclass : #GtFixItAction,
	#instVars : [
		'behavior'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices-FixIt'
}

{ #category : #executing }
GtRemoveMethodFixItAction >> basicExecuteOn: anEditorElement [
	behavior removeSelector: node selector
]

{ #category : #accessing }
GtRemoveMethodFixItAction >> behavior: aBehavior [
	behavior := aBehavior
]

{ #category : #'api - action' }
GtRemoveMethodFixItAction >> description [
	^ 'Remove ' , node selector
]

{ #category : #'api - action' }
GtRemoveMethodFixItAction >> id [
	^ GtRemoveMessageFixItActionElementId
]
