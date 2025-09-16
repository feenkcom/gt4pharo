Class {
	#name : #GtExecutedRefactoringsNotAppliedState,
	#superclass : #GtExecutedRefactoringsState,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #visiting }
GtExecutedRefactoringsNotAppliedState >> acceptVisitor: aVisitor [
	^ aVisitor visitExecutedRefactoringsNotAppliedState: self
]

{ #category : #'api - state' }
GtExecutedRefactoringsNotAppliedState >> canBeApplied [
	<return: #Boolean>
	^ true
]

{ #category : #'api - state' }
GtExecutedRefactoringsNotAppliedState >> canBeReplaced [
	"Return true if corresponding executed refactorings can be replaced by another executed refactorings"

	<return: #Boolean>
	^ true
]

{ #category : #'api - state' }
GtExecutedRefactoringsNotAppliedState >> ifBeforeApplyingDo: aBlock [
	aBlock value
]

{ #category : #'api - state' }
GtExecutedRefactoringsNotAppliedState >> previewed [
	^ GtExecutedRefactoringsState previewed
]
