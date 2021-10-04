Class {
	#name : #GtCoderBaseSmalltalkBehavior,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Coder-Environment-Smalltalk-Core'
}

{ #category : #'instance creation' }
GtCoderBaseSmalltalkBehavior class >> fromJSONDictionary: aDictionary [
	^ self new
		name: (aDictionary at: #name)
]

{ #category : #converting }
GtCoderBaseSmalltalkBehavior >> asDictionaryForExport [
	"Answer the receiver as a dictionary ready for JSON serialisation.
	Subclasses will override and add to the dictionary"

	^ Dictionary new 
		at: #name put: self name;
		yourself
]

{ #category : #accessing }
GtCoderBaseSmalltalkBehavior >> name [

	^ name
]

{ #category : #accessing }
GtCoderBaseSmalltalkBehavior >> name: anObject [
	name := anObject
]
