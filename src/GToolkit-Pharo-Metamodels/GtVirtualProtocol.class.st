Class {
	#name : #GtVirtualProtocol,
	#superclass : #GtAbstractProtocol,
	#instVars : [
		'theClass'
	],
	#category : #'GToolkit-Pharo-Metamodels-Protocols'
}

{ #category : #'as yet unclassified' }
GtVirtualProtocol class >> ofClass: aClass [
	^ self new theClass: aClass
]

{ #category : #comparing }
GtVirtualProtocol >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ theClass = anObject theClass
]

{ #category : #testing }
GtVirtualProtocol >> canBeRemoved [
	^ false
]

{ #category : #testing }
GtVirtualProtocol >> canBeRenamed [
	^ false
]

{ #category : #testing }
GtVirtualProtocol >> canBeShownWhenEmpty [
	^ false
]

{ #category : #comparing }
GtVirtualProtocol >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ theClass hash
]

{ #category : #testing }
GtVirtualProtocol >> isVirtualProtocol [
	^ true
]

{ #category : #accessing }
GtVirtualProtocol >> protocolClass [
	^ theClass
]

{ #category : #accessing }
GtVirtualProtocol >> theClass [
	^ theClass
]

{ #category : #accessing }
GtVirtualProtocol >> theClass: anObject [
	theClass := anObject instanceSide
]
