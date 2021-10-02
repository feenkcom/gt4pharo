Class {
	#name : #GtCoderSmalltalkMethod,
	#superclass : #GtCoderBaseSmalltalkMethod,
	#instVars : [
		'environment'
	],
	#category : #'GToolkit-Coder-Environment-Smalltalk'
}

{ #category : #'instance creation' }
GtCoderSmalltalkMethod class >> smalltalkBehaviorClass [
	^ GtCoderSmalltalkBehavior
]

{ #category : #accessing }
GtCoderSmalltalkMethod >> environment [

	^ environment
]

{ #category : #accessing }
GtCoderSmalltalkMethod >> environment: anObject [
	environment := anObject.
	behavior environment: anObject
]

{ #category : #'api - queries' }
GtCoderSmalltalkMethod >> protocol [
	^ environment methodProtocolOf: self
]

{ #category : #'api - queries' }
GtCoderSmalltalkMethod >> sourceCode [
	^ environment methodSourceCodeOf: self
]
