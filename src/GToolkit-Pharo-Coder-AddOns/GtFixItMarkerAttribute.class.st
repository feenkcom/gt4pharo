Class {
	#name : #GtFixItMarkerAttribute,
	#superclass : #BrTextInvisibleMarkerAttribute,
	#instVars : [
		'fixItAttribute'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtFixItMarkerAttribute >> fixItAttribute [
	^ fixItAttribute
]

{ #category : #accessing }
GtFixItMarkerAttribute >> fixItAttribute: aFixItAttribute [
	fixItAttribute := aFixItAttribute
]

{ #category : #testing }
GtFixItMarkerAttribute >> mayHaveExternalReferences [
	^ true
]
