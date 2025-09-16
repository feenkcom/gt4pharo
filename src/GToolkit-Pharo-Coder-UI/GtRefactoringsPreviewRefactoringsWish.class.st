Class {
	#name : #GtRefactoringsPreviewRefactoringsWish,
	#superclass : #BrWish,
	#instVars : [
		'refactoringsBlock'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #accessing }
GtRefactoringsPreviewRefactoringsWish >> refactoringsBlock [
	"I return a block that computes a collection of refactoring objects"

	<return: #BlockClosure of: #Collection of: #Collection>
	^ refactoringsBlock
]

{ #category : #'private - event handling' }
GtRefactoringsPreviewRefactoringsWish >> refactoringsBlock: aBlock [
	refactoringsBlock := aBlock
]
