Class {
	#name : #GtExecutedRefactoringsFailedState,
	#superclass : #GtExecutedRefactoringsState,
	#instVars : [
		'exception'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #visiting }
GtExecutedRefactoringsFailedState >> acceptVisitor: aVisitor [
	^ aVisitor visitExecutedRefactoringsFailedState: self
]

{ #category : #accessing }
GtExecutedRefactoringsFailedState >> exception [
	^ exception
]

{ #category : #accessing }
GtExecutedRefactoringsFailedState >> exception: anObject [
	exception := anObject
]

{ #category : #'api - state' }
GtExecutedRefactoringsFailedState >> ifFailedStateDo: aBlock [
	"Block receives an exception: [ :anException | ... ]"

	aBlock value: self exception
]
