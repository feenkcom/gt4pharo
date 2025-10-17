Class {
	#name : #GtRefactoringsViewModelWish,
	#superclass : #BrWish,
	#instVars : [
		'refactoringsViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
}

{ #category : #accessing }
GtRefactoringsViewModelWish >> refactoringsViewModel [
	^ refactoringsViewModel
]

{ #category : #accessing }
GtRefactoringsViewModelWish >> refactoringsViewModel: anObject [
	refactoringsViewModel := anObject
]

{ #category : #accessing }
GtRefactoringsViewModelWish >> refactoringsViewModelDo: aBlock [
	refactoringsViewModel ifNotNil: aBlock
]
