Class {
	#name : #GtRefactoringsViewModelTargetNameChanged,
	#superclass : #GtRefactoringsViewModelAnnouncement,
	#instVars : [
		'targetName'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
}

{ #category : #accessing }
GtRefactoringsViewModelTargetNameChanged >> targetName [
	^ targetName
]

{ #category : #accessing }
GtRefactoringsViewModelTargetNameChanged >> targetName: anObject [
	targetName := anObject
]
