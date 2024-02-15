Class {
	#name : #GtRefactoringWithInputChangesAttribute,
	#superclass : #GtRefactoringChangesAttribute,
	#instVars : [
		'editorElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtRefactoringWithInputChangesAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| previewButton |
	previewButton := GtRefactoringsWithInputPreviewElement new.
	previewButton editorElement: editorElement.
	previewButton vMatchParent.
	previewButton refactorings: [ refactoring ifNil: [ #() ] ifNotNil: [ {refactoring} ] ].
	previewButton
		padding: (BlInsets
				top: 1
				right: 4
				bottom: 0
				left: 4).
	previewButton cancelBlock: cancelAction.
	previewButton beMiniSize.
	previewButton
		when: GtRefactoringsAppliedEvent
		do: [ :event | completionAction notNil ifTrue: [ completionAction cull: event ] ].
	showWhenCreated ifTrue: [ previewButton enqueueTask: [ previewButton openPreview ] asBlTask ].
	^ previewButton
]

{ #category : #accessing }
GtRefactoringWithInputChangesAttribute >> editorElement [
	^ editorElement
]

{ #category : #accessing }
GtRefactoringWithInputChangesAttribute >> editorElement: anObject [
	editorElement := anObject
]
