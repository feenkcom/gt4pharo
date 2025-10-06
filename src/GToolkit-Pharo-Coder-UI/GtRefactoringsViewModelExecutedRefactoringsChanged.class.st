Class {
	#name : #GtRefactoringsViewModelExecutedRefactoringsChanged,
	#superclass : #GtRefactoringsViewModelAnnouncement,
	#instVars : [
		'executedRefactorings',
		'isPreviewed'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
}

{ #category : #accessing }
GtRefactoringsViewModelExecutedRefactoringsChanged >> executedRefactorings [
	^ executedRefactorings
]

{ #category : #accessing }
GtRefactoringsViewModelExecutedRefactoringsChanged >> executedRefactorings: anObject [
	executedRefactorings := anObject
]

{ #category : #accessing }
GtRefactoringsViewModelExecutedRefactoringsChanged >> isPreviewed [
	^ isPreviewed ifNil: [ false ]
]

{ #category : #accessing }
GtRefactoringsViewModelExecutedRefactoringsChanged >> isPreviewed: aBoolean [
	"Set true if a new refactorings is (about to be) previewed."

	isPreviewed := aBoolean
]
