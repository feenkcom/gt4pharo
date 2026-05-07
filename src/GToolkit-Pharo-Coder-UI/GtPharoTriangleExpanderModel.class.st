Class {
	#name : #GtPharoTriangleExpanderModel,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Attributes'
}

{ #category : #accessing }
GtPharoTriangleExpanderModel >> announcer [
	^ announcer
]

{ #category : #initialization }
GtPharoTriangleExpanderModel >> initialize [
	super initialize.
	announcer := Announcer new
]
