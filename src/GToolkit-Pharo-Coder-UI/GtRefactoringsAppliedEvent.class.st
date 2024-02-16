Class {
	#name : #GtRefactoringsAppliedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'refactorings'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtRefactoringsAppliedEvent >> refactorings [
	^ refactorings
]

{ #category : #accessing }
GtRefactoringsAppliedEvent >> refactorings: anObject [
	refactorings := anObject
]
