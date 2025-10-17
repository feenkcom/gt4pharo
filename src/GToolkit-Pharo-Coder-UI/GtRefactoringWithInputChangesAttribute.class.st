Class {
	#name : #GtRefactoringWithInputChangesAttribute,
	#superclass : #GtRefactoringChangesAttribute,
	#instVars : [
		'editorElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #testing }
GtRefactoringWithInputChangesAttribute class >> isDeprecated [
	"Use `GtRefactoringWithInputWidgetChangesAttribute` instead."

	^ true
]

{ #category : #'private - updating' }
GtRefactoringWithInputChangesAttribute >> createRefactoringsViewModel [
	^ GtRefactoringsWithInputWidgetViewModel new
]

{ #category : #accessing }
GtRefactoringWithInputChangesAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| button |
	button := super doAffect: aTBrTextEditorTextualPiece in: anEditorElement.
	button refactoringsViewModel inputElement: editorElement.
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
GtRefactoringWithInputChangesAttribute >> refactorings [
	^ refactoring ifNil: [ #() ] ifNotNil: [ {refactoring} ]
]
