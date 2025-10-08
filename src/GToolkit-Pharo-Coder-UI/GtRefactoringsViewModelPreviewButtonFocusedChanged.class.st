Class {
	#name : #GtRefactoringsViewModelPreviewButtonFocusedChanged,
	#superclass : #GtRefactoringsViewModelAnnouncement,
	#instVars : [
		'isFocused'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
}

{ #category : #accessing }
GtRefactoringsViewModelPreviewButtonFocusedChanged >> isFocused [
	^ isFocused
]

{ #category : #accessing }
GtRefactoringsViewModelPreviewButtonFocusedChanged >> isFocused: anObject [
	isFocused := anObject
]
