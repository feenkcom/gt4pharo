Class {
	#name : #GtAdviceAction,
	#superclass : #Object,
	#instVars : [
		'title'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-ObjectAdvices'
}

{ #category : #accessing }
GtAdviceAction >> defaultTitle [
	^ self class name
]

{ #category : #executing }
GtAdviceAction >> executeOn: anElement [
	self subclassResponsibility
]

{ #category : #printing }
GtAdviceAction >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream print: (self title ifNil: ['']) ]
]

{ #category : #accessing }
GtAdviceAction >> title [
	^ title ifNil: [ self defaultTitle ]
]

{ #category : #accessing }
GtAdviceAction >> title: aBlText [
	title := aBlText
]
