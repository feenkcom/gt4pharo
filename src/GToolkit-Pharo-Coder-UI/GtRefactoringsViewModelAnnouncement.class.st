Class {
	#name : #GtRefactoringsViewModelAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'refactoringsViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
}

{ #category : #accessing }
GtRefactoringsViewModelAnnouncement >> refactoringsViewModel [
	^ refactoringsViewModel
]

{ #category : #accessing }
GtRefactoringsViewModelAnnouncement >> refactoringsViewModel: anObject [
	refactoringsViewModel := anObject
]
