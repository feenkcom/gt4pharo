Class {
	#name : #GtExecutedRefactoringsPreviewedState,
	#superclass : #GtExecutedRefactoringsState,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #'api - state' }
GtExecutedRefactoringsPreviewedState >> canBeApplied [
	<return: #Boolean>
	^ true
]

{ #category : #'api - state' }
GtExecutedRefactoringsPreviewedState >> canBeReplaced [
	"Return true if corresponding executed refactorings can be replaced by another executed refactorings"

	<return: #Boolean>
	^ true
]

{ #category : #'api - state' }
GtExecutedRefactoringsPreviewedState >> ifBeforeApplyingDo: aBlock [
	aBlock value
]

{ #category : #'api - state' }
GtExecutedRefactoringsPreviewedState >> isPreviewed [
	"Return true if corresponding executed refactorings is previewed"

	<return: #Boolean>
	^ true
]
