Class {
	#name : #GtRefactoringsViewModelExecutedRefactoringsStateAnnouncement,
	#superclass : #GtRefactoringsViewModelAnnouncement,
	#instVars : [
		'executedRefactorings'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #accessing }
GtRefactoringsViewModelExecutedRefactoringsStateAnnouncement >> executedRefactorings [
	^ executedRefactorings
]

{ #category : #accessing }
GtRefactoringsViewModelExecutedRefactoringsStateAnnouncement >> executedRefactorings: anObject [
	executedRefactorings := anObject
]
