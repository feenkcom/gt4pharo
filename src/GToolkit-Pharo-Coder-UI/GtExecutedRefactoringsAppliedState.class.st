Class {
	#name : #GtExecutedRefactoringsAppliedState,
	#superclass : #GtExecutedRefactoringsState,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
}

{ #category : #visiting }
GtExecutedRefactoringsAppliedState >> acceptVisitor: aVisitor [
	^ aVisitor visitExecutedRefactoringsAppliedState: self
]

{ #category : #'api - state' }
GtExecutedRefactoringsAppliedState >> applyingProgress [
	"Return progress of applied changes.
	Fraction is number between 0 and 1: <0;1>"

	<return: #Number>
	^ 1
]

{ #category : #'api - state' }
GtExecutedRefactoringsAppliedState >> ifAppliedDo: aBlock [
	aBlock value
]
