Class {
	#name : #GtExecutedRefactoringsFailedState,
	#superclass : #GtExecutedRefactoringsState,
	#instVars : [
		'exception'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #'api - state' }
GtExecutedRefactoringsFailedState >> canBeReplaced [
	"Return true if corresponding executed refactorings can be replaced by another executed refactorings"

	<return: #Boolean>
	^ true
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
