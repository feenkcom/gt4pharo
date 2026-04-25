Class {
	#name : #GtPharoRenameSelectorPartModelAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'selectorPartModel',
		'source'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorPartModelAnnouncement >> selectorPartModel [
	^ selectorPartModel
]

{ #category : #accessing }
GtPharoRenameSelectorPartModelAnnouncement >> selectorPartModel: anObject [
	selectorPartModel := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorPartModelAnnouncement >> source [
	^ source
]

{ #category : #accessing }
GtPharoRenameSelectorPartModelAnnouncement >> source: anObject [
	source := anObject
]
