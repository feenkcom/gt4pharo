Class {
	#name : #GtMoveVariableRefactoringController,
	#superclass : #GtMoveTemporaryRefactoringController,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Variables'
}

{ #category : #accessing }
GtMoveVariableRefactoringController >> refactoring [
	| model |
	model := self createRefactoringModel..
	^ RBMoveVariableDefinitionRefactoring
		  model: model
		  bindTight: variableNode sourceInterval
		  in: (model classFor: sourceCoderViewModel behavior)
		  selector: sourceCoderViewModel selector
]

{ #category : #accessing }
GtMoveVariableRefactoringController >> refactoringName [
	^ 'Move variable to inner scope'
]
