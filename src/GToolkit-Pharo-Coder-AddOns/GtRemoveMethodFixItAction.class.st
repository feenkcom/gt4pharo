Class {
	#name : #GtRemoveMethodFixItAction,
	#superclass : #GtFixItAction,
	#instVars : [
		'behavior'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices-FixIt'
}

{ #category : #accessing }
GtRemoveMethodFixItAction >> behavior: aBehavior [
	behavior := aBehavior
]

{ #category : #'api - action' }
GtRemoveMethodFixItAction >> description [
	^ 'Remove ' , node selector
]

{ #category : #executing }
GtRemoveMethodFixItAction >> executeOn: anEditorElement [
	behavior removeSelector: node selector
]

{ #category : #'api - action' }
GtRemoveMethodFixItAction >> id [
	^ GtRemoveMessageFixItActionElementId
]
