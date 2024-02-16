Class {
	#name : #GtRefactoringChangesAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'refactoring',
		'completionAction',
		'cancelAction',
		'showWhenCreated',
		'focusAction'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #'private - attributes' }
GtRefactoringChangesAttribute >> cancelAction: aBlock [
	cancelAction := aBlock 
]

{ #category : #initialization }
GtRefactoringChangesAttribute >> completionAction: aBlock [
	completionAction := aBlock
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| button |
	button := self previewButtonClass new.
	button vMatchParent.
	focusAction ifNotNil: [ button focusAction: focusAction ].
	button refactorings: [ self refactorings ].
	button
		padding: (BlInsets
				top: 1
				right: 4
				bottom: 0
				left: 4).
	button cancelBlock: cancelAction.
	button beMiniSize.
	button
		when: GtRefactoringsAppliedEvent
		do: [ :event | completionAction notNil ifTrue: [ completionAction cull: event ] ].
	showWhenCreated ifTrue: [ button enqueueTask: [ button openPreview ] asBlTask ].
	^ button
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> focusAction [
	^ focusAction
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> focusAction: anObject [
	focusAction := anObject
]

{ #category : #initialization }
GtRefactoringChangesAttribute >> initialize [
	super initialize.
	self beAppend.
	self beNotOverwritableByStyler.
	showWhenCreated := false
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> previewButtonClass [
	^ GtRefactoringsPreviewButton
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> refactoring [
	^ refactoring
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> refactoring: aRBRefactoring [
	refactoring := aRBRefactoring
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> refactorings [
	^ {refactoring}
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> showWhenCreated [
	^ showWhenCreated
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> showWhenCreated: aBoolean [
	showWhenCreated := aBoolean
]
