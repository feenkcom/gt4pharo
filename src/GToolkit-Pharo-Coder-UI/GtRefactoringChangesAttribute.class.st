Class {
	#name : #GtRefactoringChangesAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'refactoring',
		'completionAction',
		'cancelAction',
		'showWhenCreated'
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
	button := GtRefactoringsPreviewButton new.
	button vMatchParent.
	button refactorings: [ {refactoring} ].
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

{ #category : #initialization }
GtRefactoringChangesAttribute >> initialize [
	super initialize.
	self beAppend.
	self beNotOverwritableByStyler.
	showWhenCreated := false
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> refactoring: aRBRefactoring [
	refactoring := aRBRefactoring
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> showWhenCreated [
	^ showWhenCreated
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> showWhenCreated: aBoolean [
	showWhenCreated := aBoolean
]
