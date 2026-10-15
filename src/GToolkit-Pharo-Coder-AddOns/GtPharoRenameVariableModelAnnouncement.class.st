Class {
	#name : #GtPharoRenameVariableModelAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'variableModel',
		'source'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameVariableModelAnnouncement >> source [
	^ source
]

{ #category : #accessing }
GtPharoRenameVariableModelAnnouncement >> source: anObject [
	source := anObject
]

{ #category : #accessing }
GtPharoRenameVariableModelAnnouncement >> variableModel [
	^ variableModel
]

{ #category : #accessing }
GtPharoRenameVariableModelAnnouncement >> variableModel: anObject [
	variableModel := anObject
]
