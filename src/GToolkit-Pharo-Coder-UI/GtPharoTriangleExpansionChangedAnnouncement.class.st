Class {
	#name : #GtPharoTriangleExpansionChangedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'isExpanded'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Attributes'
}

{ #category : #accessing }
GtPharoTriangleExpansionChangedAnnouncement >> isExpanded [
	^ isExpanded ifNil: [ false ]
]

{ #category : #accessing }
GtPharoTriangleExpansionChangedAnnouncement >> isExpanded: aBoolean [
	isExpanded := aBoolean
]
