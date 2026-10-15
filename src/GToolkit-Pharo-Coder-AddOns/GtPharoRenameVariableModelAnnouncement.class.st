"
I am the superclass of announcements of {{gtClass:GtPharoRenameVariableModel}}. I know the model and the source of the change or the request.
"
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
