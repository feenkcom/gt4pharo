Class {
	#name : #GtExecutedRefactoringsExplicitlyDisabledState,
	#superclass : #GtExecutedRefactoringsState,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
}

{ #category : #visiting }
GtExecutedRefactoringsExplicitlyDisabledState >> acceptVisitor: aVisitor [
	^ aVisitor visitExecutedRefactoringsExplicitlyDisabledState: self
]

{ #category : #'api - state' }
GtExecutedRefactoringsExplicitlyDisabledState >> enable [
	^ GtExecutedRefactoringsState notComputed
]

{ #category : #'api - state' }
GtExecutedRefactoringsExplicitlyDisabledState >> ifDisabledDo: aBlock [
	"Evaluate block if refactorings are explicitly disabled (by a user).
	Block has zero arguments."

	^ aBlock value
]

{ #category : #'api - state' }
GtExecutedRefactoringsExplicitlyDisabledState >> ifNotComputedDo: aBlock [
	aBlock value
]

{ #category : #'api - state' }
GtExecutedRefactoringsExplicitlyDisabledState >> isDisabled [
	"Return true if corresponding executed refactorings is disabled"

	<return: #Boolean>
	^ true
]
