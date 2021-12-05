Class {
	#name : #GtPharoMethodOrigin,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Method-Origin'
}

{ #category : #accessing }
GtPharoMethodOrigin >> behaviorDo: aBlock [
	"Evaluate a given block with the origin behavior"
	
	^ nil
]

{ #category : #testing }
GtPharoMethodOrigin >> isSameOrigin [
	^ false
]

{ #category : #testing }
GtPharoMethodOrigin >> isTraitOrigin [
	^ false
]
