Class {
	#name : #GtExecutedRefactoringsNotComputedState,
	#superclass : #GtExecutedRefactoringsState,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

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
GtExecutedRefactoringsNotComputedState >> ifNotComputedDo: aBlock [
	aBlock value
]
