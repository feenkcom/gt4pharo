Class {
	#name : #GtPharoSavedAnotherMethodEvent,
	#superclass : #BlEvent,
	#instVars : [
		'method',
		'previousMethod'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support'
}

{ #category : #accessing }
GtPharoSavedAnotherMethodEvent >> method [
	^ method
]

{ #category : #accessing }
GtPharoSavedAnotherMethodEvent >> method: anObject [
	method := anObject
]

{ #category : #accessing }
GtPharoSavedAnotherMethodEvent >> previousMethod [
	^ previousMethod
]

{ #category : #accessing }
GtPharoSavedAnotherMethodEvent >> previousMethod: anObject [
	previousMethod := anObject
]
