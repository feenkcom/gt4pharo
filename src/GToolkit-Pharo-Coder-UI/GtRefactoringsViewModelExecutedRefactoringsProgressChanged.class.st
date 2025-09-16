Class {
	#name : #GtRefactoringsViewModelExecutedRefactoringsProgressChanged,
	#superclass : #GtRefactoringsViewModelAnnouncement,
	#instVars : [
		'executedRefactorings',
		'fraction'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #accessing }
GtRefactoringsViewModelExecutedRefactoringsProgressChanged >> executedRefactorings [
	^ executedRefactorings
]

{ #category : #accessing }
GtRefactoringsViewModelExecutedRefactoringsProgressChanged >> executedRefactorings: anObject [
	executedRefactorings := anObject
]

{ #category : #accessing }
GtRefactoringsViewModelExecutedRefactoringsProgressChanged >> fraction [
	^ fraction
]

{ #category : #accessing }
GtRefactoringsViewModelExecutedRefactoringsProgressChanged >> fraction: anObject [
	fraction := anObject
]
