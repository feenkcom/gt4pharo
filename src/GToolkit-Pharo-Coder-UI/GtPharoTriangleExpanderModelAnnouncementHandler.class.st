Class {
	#name : #GtPharoTriangleExpanderModelAnnouncementHandler,
	#superclass : #Object,
	#instVars : [
		'element',
		'model'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Attributes'
}

{ #category : #accessing }
GtPharoTriangleExpanderModelAnnouncementHandler >> element [
	^ element
]

{ #category : #accessing }
GtPharoTriangleExpanderModelAnnouncementHandler >> element: anObject [
	element := anObject
]

{ #category : #'as yet unclassified' }
GtPharoTriangleExpanderModelAnnouncementHandler >> install [
	self assert: [ element isNotNil ].
	self assert: [ model isNotNil ].

	model announcer weak
		when: BrTextExpanderModelExpansionChangedAnnouncement
		send: #onGtPharoTriangleExpansionChangedAnnouncement:
		to: self.

	element userData at: self className put: self
]

{ #category : #accessing }
GtPharoTriangleExpanderModelAnnouncementHandler >> model [
	^ model
]

{ #category : #accessing }
GtPharoTriangleExpanderModelAnnouncementHandler >> model: anObject [
	model := anObject
]

{ #category : #'private - event handling' }
GtPharoTriangleExpanderModelAnnouncementHandler >> onGtPharoTriangleExpansionChangedAnnouncement: anAnnouncement [
	anAnnouncement isExpanded
		ifTrue: [ self element visibility: BlVisibility visible ]
		ifFalse: [ self element visibility: BlVisibility gone ]
]
