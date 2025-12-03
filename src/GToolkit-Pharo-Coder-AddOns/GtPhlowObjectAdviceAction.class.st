Class {
	#name : #GtPhlowObjectAdviceAction,
	#superclass : #GtAdviceAction,
	#instVars : [
		'object'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-ObjectAdvices'
}

{ #category : #'instance creation' }
GtPhlowObjectAdviceAction class >> object: anObject [
	^ self new
		object: anObject;
		yourself
]

{ #category : #accessing }
GtPhlowObjectAdviceAction >> defaultTitle [
	^ ('Inspect ' , object printString) asRopedText
]

{ #category : #accessing }
GtPhlowObjectAdviceAction >> executeOn: anElement [
	anElement phlow spawnObject: object
]

{ #category : #initialization }
GtPhlowObjectAdviceAction >> object: anObject [

	object := anObject
]
