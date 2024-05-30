Class {
	#name : #GtListAdvice,
	#superclass : #GtAdvice,
	#instVars : [
		'items',
		'compute'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Object Advices'
}

{ #category : #accessing }
GtListAdvice >> compute [
	^ compute
]

{ #category : #accessing }
GtListAdvice >> compute: aBlock [
	compute := aBlock
]

{ #category : #testing }
GtListAdvice >> hasAdvice [
	^ self result notEmpty
]

{ #category : #initialization }
GtListAdvice >> initialize [
	super initialize.
	compute := [ #() ]
]

{ #category : #'as yet unclassified' }
GtListAdvice >> refresh [
	items := nil
]

{ #category : #accessing }
GtListAdvice >> result [
	^ items ifNil: [ items := compute value ]
]

{ #category : #enumerating }
GtListAdvice >> resultsDo: aBlock [
	self result do: aBlock
]
