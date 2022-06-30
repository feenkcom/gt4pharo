Class {
	#name : #GtAdviceAction,
	#superclass : #Object,
	#instVars : [
		'title'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Advice'
}

{ #category : #accessing }
GtAdviceAction >> defaultTitle [
	^ self class name
]

{ #category : #executing }
GtAdviceAction >> executeOn: anElement [
	self subclassResponsibility
]

{ #category : #accessing }
GtAdviceAction >> title [
	^ title ifNil: [ self defaultTitle ]
]

{ #category : #accessing }
GtAdviceAction >> title: aBlText [
	title := aBlText
]
