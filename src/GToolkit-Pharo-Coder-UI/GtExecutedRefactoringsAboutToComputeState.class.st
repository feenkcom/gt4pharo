Class {
	#name : #GtExecutedRefactoringsAboutToComputeState,
	#superclass : #GtExecutedRefactoringsState,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
}

{ #category : #visiting }
GtExecutedRefactoringsAboutToComputeState >> acceptVisitor: aVisitor [
	^ aVisitor visitExecutedRefactoringsAboutToComputeState: self
]

{ #category : #'api - state' }
GtExecutedRefactoringsAboutToComputeState >> canBeReplaced [
	"Return true if corresponding executed refactorings can be replaced by another executed refactorings"

	<return: #Boolean>
	^ true
]

{ #category : #'api - state' }
GtExecutedRefactoringsAboutToComputeState >> ifBeforeApplyingDo: aBlock [
	aBlock value
]

{ #category : #'api - state' }
GtExecutedRefactoringsAboutToComputeState >> ifComputationInProgressDo: aBlock [
	aBlock value
]
