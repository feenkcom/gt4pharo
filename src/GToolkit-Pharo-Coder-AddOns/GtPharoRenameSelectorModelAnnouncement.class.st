Class {
	#name : #GtPharoRenameSelectorModelAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'selectorModel',
		'source'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorModelAnnouncement >> selectorModel [
	^ selectorModel
]

{ #category : #accessing }
GtPharoRenameSelectorModelAnnouncement >> selectorModel: anObject [
	selectorModel := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorModelAnnouncement >> source [
	^ source
]

{ #category : #accessing }
GtPharoRenameSelectorModelAnnouncement >> source: anObject [
	source := anObject
]
