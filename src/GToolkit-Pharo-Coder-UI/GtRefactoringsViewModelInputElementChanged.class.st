Class {
	#name : #GtRefactoringsViewModelInputElementChanged,
	#superclass : #GtRefactoringsViewModelAnnouncement,
	#instVars : [
		'inputElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
}

{ #category : #accessing }
GtRefactoringsViewModelInputElementChanged >> inputElement [
	^ inputElement
]

{ #category : #accessing }
GtRefactoringsViewModelInputElementChanged >> inputElement: anObject [
	inputElement := anObject
]
