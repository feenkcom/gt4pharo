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
