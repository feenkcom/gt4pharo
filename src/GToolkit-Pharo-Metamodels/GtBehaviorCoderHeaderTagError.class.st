Class {
	#name : #GtBehaviorCoderHeaderTagError,
	#superclass : #GtBehaviorCoderHeaderError,
	#instVars : [
		'tagName'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Errors'
}

{ #category : #signalling }
GtBehaviorCoderHeaderTagError class >> signalFor: aTagName [
	(self new tagName: aTagName) signal
]

{ #category : #accessing }
GtBehaviorCoderHeaderTagError >> tagName [
	^ tagName
]

{ #category : #accessing }
GtBehaviorCoderHeaderTagError >> tagName: anObject [
	tagName := anObject
]
