Class {
	#name : #GtPharoMethodOrigin,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Method-Origin'
}

{ #category : #accessing }
GtPharoMethodOrigin >> behaviorDo: aBlock [
	"Evaluate a given block with the origin behavior"
	
	^ self
		behaviorDo: aBlock
		ifUnknown: [ nil ]
]

{ #category : #accessing }
GtPharoMethodOrigin >> behaviorDo: aBlock ifUnknown: anUnknownBlock [
	"Evaluate a given block with the origin behavior"
	
	^ self subclassResponsibility
]

{ #category : #testing }
GtPharoMethodOrigin >> isSameOrigin [
	^ false
]

{ #category : #testing }
GtPharoMethodOrigin >> isTraitOrigin [
	^ false
]

{ #category : #testing }
GtPharoMethodOrigin >> isUnknownOrigin [
	^ false
]

{ #category : #accessing }
GtPharoMethodOrigin >> originalMethodDo: aBlock ifUnknown: anUnknownBlock [
	"Evaluate a given block with the origin behavior and method"
	
	^ self subclassResponsibility
]
