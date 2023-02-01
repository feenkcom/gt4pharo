Class {
	#name : #GtPP2InlineProductionRefactoringController,
	#superclass : #GtPharoSourceCoderRefactoringController,
	#instVars : [
		'variableNode'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #accessing }
GtPP2InlineProductionRefactoringController >> previewDisplaysImmediately [
	^ true
]

{ #category : #accessing }
GtPP2InlineProductionRefactoringController >> previewPosition [
	^ variableNode stopPosition
]

{ #category : #accessing }
GtPP2InlineProductionRefactoringController >> refactoring [
	^ GtPP2InlineProductionRefactoring
		model: self createModel
		inline: variableNode sourceInterval
		inMethod: sourceCoderViewModel coderModel currentSelector
		forClass: sourceCoderViewModel behavior
]

{ #category : #accessing }
GtPP2InlineProductionRefactoringController >> refactoringName [
	^ 'Inline production'
]

{ #category : #executing }
GtPP2InlineProductionRefactoringController >> safelyExecute [
	self addRefactoringPreview
]

{ #category : #accessing }
GtPP2InlineProductionRefactoringController >> variableNode [
	^ variableNode
]

{ #category : #accessing }
GtPP2InlineProductionRefactoringController >> variableNode: aVariableNode [
	variableNode := aVariableNode
]
