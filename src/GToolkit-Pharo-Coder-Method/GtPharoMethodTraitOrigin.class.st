Class {
	#name : #GtPharoMethodTraitOrigin,
	#superclass : #GtPharoMethodOrigin,
	#instVars : [
		'trait',
		'method'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Origin'
}

{ #category : #testing }
GtPharoMethodTraitOrigin >> isTraitOrigin [
	^ true
]

{ #category : #accessing }
GtPharoMethodTraitOrigin >> method [

	^ method
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
