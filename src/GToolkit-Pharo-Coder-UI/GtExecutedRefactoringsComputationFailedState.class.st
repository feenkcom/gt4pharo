Class {
	#name : #GtExecutedRefactoringsComputationFailedState,
	#superclass : #GtExecutedRefactoringsState,
	#instVars : [
		'exception'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #visiting }
GtExecutedRefactoringsComputationFailedState >> acceptVisitor: aVisitor [
	^ aVisitor visitExecutedRefactoringsComputationFailedState: self
]

{ #category : #'api - state' }
GtExecutedRefactoringsComputationFailedState >> canBeReplaced [
	"Return true if corresponding executed refactorings can be replaced by another executed refactorings"

	<return: #Boolean>
	^ true
]

{ #category : #accessing }
GtExecutedRefactoringsComputationFailedState >> exception [
	^ exception
]

{ #category : #accessing }
GtExecutedRefactoringsComputationFailedState >> exception: anObject [
	exception := anObject
]

{ #category : #'api - state' }
GtExecutedRefactoringsComputationFailedState >> ifBeforeApplyingDo: aBlock [
	aBlock value
]

{ #category : #'api - state' }
GtExecutedRefactoringsComputationFailedState >> ifComputationFailedDo: aBlock [
	"Block receives an exception: [ :anException | ... ]"

	aBlock value: self exception
]

{ #category : #'api - state' }
GtExecutedRefactoringsComputationFailedState >> ifFailedStateDo: aBlock [
	"Block receives an exception: [ :anException | ... ]"

	aBlock value: self exception
]
