Class {
	#name : #GtExecutedRefactoringsRunningState,
	#superclass : #GtExecutedRefactoringsState,
	#instVars : [
		'promise',
		'fraction'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
}

{ #category : #visiting }
GtExecutedRefactoringsRunningState >> acceptVisitor: aVisitor [
	^ aVisitor visitExecutedRefactoringsRunningState: self
]

{ #category : #accessing }
GtExecutedRefactoringsRunningState >> applyingProgress [
	"Return progress of applied changes.
	Fraction is number between 0 and 1: <0;1>"

	<return: #Number>
	^ self fraction
]

{ #category : #'api - state' }
GtExecutedRefactoringsRunningState >> applyingProgress: aFraction [
	"Set progress of applied changes.
	Fraction is number between 0 and 1: <0;1>"

	^ self class new
		promise: promise;
		fraction: aFraction
]

{ #category : #accessing }
GtExecutedRefactoringsRunningState >> fraction [
	"Return progress of applied changes.
	Fraction is number between 0 and 1: <0;1>"

	<return: #Number>
	^ fraction
]

{ #category : #accessing }
GtExecutedRefactoringsRunningState >> fraction: aFraction [
	"Set progress of applied changes.
	Fraction is number between 0 and 1: <0;1>"

	fraction := aFraction
]

{ #category : #'api - state' }
GtExecutedRefactoringsRunningState >> ifApplyingDo: aBlock [
	aBlock value
]

{ #category : #initialization }
GtExecutedRefactoringsRunningState >> initialize [
	super initialize.
	fraction := 0
]

{ #category : #accessing }
GtExecutedRefactoringsRunningState >> promise [
	^ promise
]

{ #category : #accessing }
GtExecutedRefactoringsRunningState >> promise: anObject [
	promise := anObject
]
