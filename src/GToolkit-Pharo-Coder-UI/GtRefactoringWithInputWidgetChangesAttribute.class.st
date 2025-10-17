Class {
	#name : #GtRefactoringWithInputWidgetChangesAttribute,
	#superclass : #GtRefactoringChangesAttribute,
	#instVars : [
		'inputElementStencil'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #'private - updating' }
GtRefactoringWithInputWidgetChangesAttribute >> createRefactoringsViewModel [
	^ GtRefactoringsWithInputWidgetViewModel new 
		refactoringsWithConfirmation: [ self refactorings ];
		yourself
]

{ #category : #accessing }
GtRefactoringWithInputWidgetChangesAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| button |
	button := super doAffect: aTBrTextEditorTextualPiece in: anEditorElement.

	button refactoringsViewModel inputElement: inputElementStencil.
	^ button
]

{ #category : #'api - initialization' }
GtRefactoringWithInputWidgetChangesAttribute >> inputElement: aStencil [
	"Input element stencil builder creates elements.
	It can also return `nil` instead of a BlElement instance.
	The stencil builder can be a block with one argument [ :aRefactoringsViewModel | ]."

	inputElementStencil := aStencil
			asStencilBuilder: GtRefactoringsInputWidgetStencilBuilder
]

{ #category : #'api - initialization' }
GtRefactoringWithInputWidgetChangesAttribute >> inputElementStencil [
	^ inputElementStencil
]

{ #category : #accessing }
GtRefactoringWithInputWidgetChangesAttribute >> refactorings [
	^ refactoring ifNil: [ #() ] ifNotNil: [ {refactoring} ]
]
