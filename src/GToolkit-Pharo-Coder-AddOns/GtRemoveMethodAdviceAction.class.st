Class {
	#name : #GtRemoveMethodAdviceAction,
	#superclass : #GtAdviceAction,
	#instVars : [
		'behavior',
		'selector'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-ObjectAdvices'
}

{ #category : #'instance creation' }
GtRemoveMethodAdviceAction class >> remove: aSelector from: aClass [
	^ self new
		remove: aSelector from: aClass;
		yourself
]

{ #category : #initialization }
GtRemoveMethodAdviceAction >> defaultTitle [
	^ ('Remove #' , selector) asRopedText
]

{ #category : #executing }
GtRemoveMethodAdviceAction >> executeOn: anElement [
	(RBRemoveMethodChange remove: selector from: behavior) execute
]

{ #category : #initialization }
GtRemoveMethodAdviceAction >> remove: aSelector from: aClass [
	selector := aSelector.
	behavior := aClass
]
