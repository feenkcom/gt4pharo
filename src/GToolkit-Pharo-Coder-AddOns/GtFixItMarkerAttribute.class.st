Class {
	#name : #GtFixItMarkerAttribute,
	#superclass : #BrTextInvisibleMarkerAttribute,
	#instVars : [
		'fixItAttribute'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtFixItMarkerAttribute >> fixItAttribute [
	^ fixItAttribute
]

{ #category : #accessing }
GtFixItMarkerAttribute >> fixItAttribute: aFixItAttribute [
	fixItAttribute := aFixItAttribute
]

{ #category : #'gt - extensions' }
GtFixItMarkerAttribute >> gtUserDataFor: aView [
	<gtView>
	userData ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'User data';
		items: [ userData associations ];
		column: 'Key' text: [ :each | each key gtDisplayString ];
		column: 'Value'
			text: [ :each | each value gtDisplayString ]
			weight: 3;
		send: [ :each | each value ]
]

{ #category : #testing }
GtFixItMarkerAttribute >> mayHaveExternalReferences [
	^ true
]
