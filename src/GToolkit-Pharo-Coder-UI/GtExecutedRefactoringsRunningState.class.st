Class {
	#name : #GtExecutedRefactoringsRunningState,
	#superclass : #GtExecutedRefactoringsState,
	#instVars : [
		'promise'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #'api - state' }
GtExecutedRefactoringsRunningState >> ifApplyingDo: aBlock [
	aBlock value
]

{ #category : #accessing }
GtExecutedRefactoringsRunningState >> promise [
	^ promise
]

{ #category : #accessing }
GtExecutedRefactoringsRunningState >> promise: anObject [
	promise := anObject
]
