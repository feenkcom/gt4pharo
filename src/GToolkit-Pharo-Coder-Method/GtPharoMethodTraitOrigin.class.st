Class {
	#name : #GtPharoMethodTraitOrigin,
	#superclass : #GtPharoMethodOrigin,
	#instVars : [
		'trait',
		'method'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Origin'
}

{ #category : #enumerating }
GtPharoMethodTraitOrigin >> behaviorDo: aBlock ifUnknown: anUnknownBlock [
	"Evaluate a given block with the origin behavior"

	^ aBlock value: trait
]

{ #category : #testing }
GtPharoMethodTraitOrigin >> isTraitOrigin [
	^ true
]

{ #category : #accessing }
GtPharoMethodTraitOrigin >> method [

	^ method
]

{ #category : #accessing }
GtPharoMethodTraitOrigin >> originalMethod [

	^ trait >> method selector
]

{ #category : #enumerating }
GtPharoMethodTraitOrigin >> originalMethodDo: aBlock ifUnknown: anUnknownBlock [
	"Evaluate a given block with the origin behavior and method"

	^ aBlock value: trait value: self originalMethod
]

{ #category : #accessing }
GtPharoMethodTraitOrigin >> trait [

	^ trait
]

{ #category : #accessing }
GtPharoMethodTraitOrigin >> trait: anObject [

	trait := anObject
]

{ #category : #accessing }
GtPharoMethodTraitOrigin >> trait: anObject method: aCompiledMethod [
	trait := anObject.
	method := aCompiledMethod
]
