Class {
	#name : #GtRefactoringsConfiguration,
	#superclass : #Object,
	#instVars : [
		'refactoringsBlock',
		'completionAction',
		'cancelAction',
		'showWhenCreated',
		'focusAction',
		'refactoringsViewModelDo'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtRefactoringsConfiguration >> cancelAction [
	^ cancelAction
]

{ #category : #accessing }
GtRefactoringsConfiguration >> cancelAction: aBlock [
	cancelAction := aBlock 
]

{ #category : #accessing }
GtRefactoringsConfiguration >> completionAction [
	^ completionAction
]

{ #category : #accessing }
GtRefactoringsConfiguration >> completionAction: aBlock [
	"Action that is called when refactoring is complete"

	completionAction := aBlock
]

{ #category : #accessing }
GtRefactoringsConfiguration >> focusAction [
	^ focusAction
]

{ #category : #accessing }
GtRefactoringsConfiguration >> focusAction: anObject [
	focusAction := anObject
]

{ #category : #accessing }
GtRefactoringsConfiguration >> refactoringsBlock [
	^ refactoringsBlock
]

{ #category : #accessing }
GtRefactoringsConfiguration >> refactoringsBlock: aBlock [
	"Block returns a collection of refactorings"

	refactoringsBlock := aBlock
]

{ #category : #accessing }
GtRefactoringsConfiguration >> refactoringsViewModelDo [
	^ refactoringsViewModelDo
]

{ #category : #accessing }
GtRefactoringsConfiguration >> refactoringsViewModelDo: aBlock [
	"Configure refactorings view model, e.g., set title.
	The block receives one argument [ :aRefactoringsViewModelDo | ]."

	refactoringsViewModelDo := aBlock
]

{ #category : #accessing }
GtRefactoringsConfiguration >> showWhenCreated [
	^ showWhenCreated
]

{ #category : #accessing }
GtRefactoringsConfiguration >> showWhenCreated: aBoolean [
	showWhenCreated := aBoolean
]
