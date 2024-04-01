Class {
	#name : #GtPharoMethodUnknownOrigin,
	#superclass : #GtPharoMethodOrigin,
	#category : #'GToolkit-Pharo-Coder-Method-Origin'
}

{ #category : #accessing }
GtPharoMethodUnknownOrigin >> behaviorDo: aBlock ifUnknown: anUnknownBlock [
	"Evaluate a given block with the origin behavior"
	
	^ anUnknownBlock value
]

{ #category : #testing }
GtPharoMethodUnknownOrigin >> isUnknownOrigin [
	^ true
]

{ #category : #accessing }
GtPharoMethodUnknownOrigin >> originalMethodDo: aBlock ifUnknown: anUnknownBlock [
	"Evaluate a given block with the origin behavior and method"
	
	^ anUnknownBlock value
]
