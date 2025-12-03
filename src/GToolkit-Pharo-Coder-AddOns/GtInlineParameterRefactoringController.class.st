Class {
	#name : #GtInlineParameterRefactoringController,
	#superclass : #GtMethodRefactoringController,
	#instVars : [
		'variableNode'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #accessing }
GtInlineParameterRefactoringController >> refactoring [
	| model refactoring |
	model := self createRefactoringModel.
	refactoring := RBInlineParameterRefactoring
		               model: model
		               inlineParameter: variableNode variableName
		               in: (model classFor: self methodClass)
		               selector: methodNode selector.
	^ refactoring
]

{ #category : #accessing }
GtInlineParameterRefactoringController >> refactoringName [
	^ 'Inline parameter ' , variableNode variableName
]

{ #category : #initialization }
GtInlineParameterRefactoringController >> variableNode: aNode [
	variableNode := aNode.
	self methodNode: aNode methodNode
]
