Class {
	#name : #GtExecutedRefactoringsAppliedState,
	#superclass : #GtExecutedRefactoringsState,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #'api - state' }
GtExecutedRefactoringsAppliedState >> canBeReplaced [
	"Return true if corresponding executed refactorings can be replaced by another executed refactorings"

	<return: #Boolean>
	^ true
]

{ #category : #'api - state' }
GtExecutedRefactoringsAppliedState >> ifAppliedDo: aBlock [
	aBlock value
]
