Class {
	#name : #GtPharoRenameSelectorPartAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'selectorPartModel',
		'source'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorPartAnnouncement >> selectorPartModel [
	^ selectorPartModel
]

{ #category : #accessing }
GtPharoRenameSelectorPartAnnouncement >> selectorPartModel: anObject [
	selectorPartModel := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorPartAnnouncement >> source [
	^ source
]

{ #category : #accessing }
GtPharoRenameSelectorPartAnnouncement >> source: anObject [
	source := anObject
]
