Class {
	#name : #GtItemAdvice,
	#superclass : #GtAdvice,
	#instVars : [
		'value',
		'compute',
		'hasComputed'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Object Advices'
}

{ #category : #accessing }
GtItemAdvice >> compute [
	^ compute
]

{ #category : #accessing }
GtItemAdvice >> compute: aBlock [
	compute := aBlock
]

{ #category : #testing }
GtItemAdvice >> hasAdvice [
	^ self result notNil
]

{ #category : #initialization }
GtItemAdvice >> initialize [
	super initialize.
	compute := [  ].
	hasComputed := false
]

{ #category : #accessing }
GtItemAdvice >> result [
	hasComputed
		ifFalse: [ value := compute value.
			hasComputed := true ].
	^ value
]

{ #category : #enumerating }
GtItemAdvice >> resultsDo: aBlock [
	self result ifNotNil: aBlock
]
