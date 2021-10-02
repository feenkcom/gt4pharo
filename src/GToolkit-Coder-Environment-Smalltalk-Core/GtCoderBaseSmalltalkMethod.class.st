Class {
	#name : #GtCoderBaseSmalltalkMethod,
	#superclass : #Object,
	#instVars : [
		'behavior',
		'selector'
	],
	#category : #'GToolkit-Coder-Environment-Smalltalk-Core'
}

{ #category : #'instance creation' }
GtCoderBaseSmalltalkMethod class >> fromJSONDictionary: aDictionary [
	^ self new
		behavior: (self smalltalkBehaviorClass fromJSONDictionary: (aDictionary at: #behavior));
		selector: (aDictionary at: #selector)
]

{ #category : #'instance creation' }
GtCoderBaseSmalltalkMethod class >> smalltalkBehaviorClass [
	^ GtCoderBaseSmalltalkBehavior
]

{ #category : #converting }
GtCoderBaseSmalltalkMethod >> asDictionaryForExport [
	"Answer the receiver as a dictionary ready for JSON serialisation.
	Subclasses will override and add to the dictionary"

	^ Dictionary new 
		at: #behavior put: self behavior asDictionaryForExport;
		at: #selector put: self selector;
		yourself
]

{ #category : #accessing }
GtCoderBaseSmalltalkMethod >> behavior [

	^ behavior
]

{ #category : #accessing }
GtCoderBaseSmalltalkMethod >> behavior: anObject [

	behavior := anObject
]

{ #category : #accessing }
GtCoderBaseSmalltalkMethod >> selector [

	^ selector
]

{ #category : #accessing }
GtCoderBaseSmalltalkMethod >> selector: anObject [

	selector := anObject
]
