"
I notify that {{gtMethod:GtRefactoringsViewModel >> executedRefactorings}} should be applied.
I am used to confirm, that a user agreed on previewed refactoring chagnes and those can be therefore applied.
"
Class {
	#name : #GtRefactoringsViewModelApplyChangesRequested,
	#superclass : #GtRefactoringsViewModelAnnouncement,
	#instVars : [
		'executedRefactorings'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #accessing }
GtRefactoringsViewModelApplyChangesRequested >> executedRefactorings [
	^ executedRefactorings
]

{ #category : #accessing }
GtRefactoringsViewModelApplyChangesRequested >> executedRefactorings: anObject [
	executedRefactorings := anObject
]
