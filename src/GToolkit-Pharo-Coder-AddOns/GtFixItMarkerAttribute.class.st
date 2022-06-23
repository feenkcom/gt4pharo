Class {
	#name : #GtFixItMarkerAttribute,
	#superclass : #BrTextInvisibleMarkerAttribute,
	#instVars : [
		'fixItAttribute'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtFixItMarkerAttribute >> fixItAttribute [
	^ fixItAttribute
]

{ #category : #accessing }
GtFixItMarkerAttribute >> fixItAttribute: aFixItAttribute [
	fixItAttribute := aFixItAttribute
]

{ #category : #opening }
GtFixItMarkerAttribute >> togglePopup [
	^ fixItAttribute ifNil: [ false ] ifNotNil: [ fixItAttribute togglePopup ]
]
