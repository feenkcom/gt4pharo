Class {
	#name : #GtExecutedRefactoringsRunningState,
	#superclass : #GtExecutedRefactoringsState,
	#instVars : [
		'promise'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #accessing }
GtExecutedRefactoringsRunningState >> promise [
	^ promise
]

{ #category : #accessing }
GtExecutedRefactoringsRunningState >> promise: anObject [
	promise := anObject
]
