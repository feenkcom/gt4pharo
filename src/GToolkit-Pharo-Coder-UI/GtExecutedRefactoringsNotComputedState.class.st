Class {
	#name : #GtExecutedRefactoringsNotComputedState,
	#superclass : #GtExecutedRefactoringsState,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
}

{ #category : #visiting }
GtExecutedRefactoringsNotComputedState >> acceptVisitor: aVisitor [
	^ aVisitor visitExecutedRefactoringsNotComputedState: self
]

{ #category : #'api - state' }
GtExecutedRefactoringsNotComputedState >> canBeApplied [
	<return: #Boolean>
	^ true
]

{ #category : #'api - state' }
GtExecutedRefactoringsNotComputedState >> canBeReplaced [
	"Return true if corresponding executed refactorings can be replaced by another executed refactorings"

	<return: #Boolean>
	^ true
]

{ #category : #'api - state' }
GtExecutedRefactoringsNotComputedState >> disable [
	"Disable refactoring, including refactoring computation and preview."

	^ GtExecutedRefactoringsState disabled
]

{ #category : #'api - state' }
GtExecutedRefactoringsNotComputedState >> ifBeforeApplyingDo: aBlock [
	aBlock value
]

{ #category : #'api - state' }
GtExecutedRefactoringsNotComputedState >> ifNotComputedDo: aBlock [
	aBlock value
]
