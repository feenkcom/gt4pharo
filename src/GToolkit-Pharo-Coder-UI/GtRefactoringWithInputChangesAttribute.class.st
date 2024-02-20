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
	| button |
	button := super doAffect: aTBrTextEditorTextualPiece in: anEditorElement.
	button editorElement: editorElement.
	^ button
]

{ #category : #accessing }
GtRefactoringWithInputChangesAttribute >> editorElement [
	^ editorElement
]

{ #category : #accessing }
GtRefactoringWithInputChangesAttribute >> editorElement: anObject [
	editorElement := anObject
]

{ #category : #accessing }
GtRefactoringWithInputChangesAttribute >> previewButtonClass [
	^ GtRefactoringsWithInputPreviewElement
]

{ #category : #accessing }
GtRefactoringWithInputChangesAttribute >> refactorings [
	^ refactoring ifNil: [ #() ] ifNotNil: [ {refactoring} ]
]
