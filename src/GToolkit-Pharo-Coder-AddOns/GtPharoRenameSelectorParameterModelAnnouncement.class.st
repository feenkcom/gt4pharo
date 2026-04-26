Class {
	#name : #GtPharoRenameSelectorParameterModelAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'source',
		'parameterModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorParameterModelAnnouncement >> parameterModel [
	^ parameterModel
]

{ #category : #accessing }
GtPharoRenameSelectorParameterModelAnnouncement >> parameterModel: anObject [
	parameterModel := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorParameterModelAnnouncement >> source [
	^ source
]

{ #category : #accessing }
GtPharoRenameSelectorParameterModelAnnouncement >> source: anObject [
	source := anObject
]
