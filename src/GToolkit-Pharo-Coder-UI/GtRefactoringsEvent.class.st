Class {
	#name : #GtRefactoringsEvent,
	#superclass : #BlEvent,
	#instVars : [
		'refactorings'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtRefactoringsEvent >> refactorings [
	^ refactorings
]

{ #category : #accessing }
GtRefactoringsEvent >> refactorings: anObject [
	refactorings := anObject
]
