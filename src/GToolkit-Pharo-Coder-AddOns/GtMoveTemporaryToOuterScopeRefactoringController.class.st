Class {
	#name : #GtMoveTemporaryToOuterScopeRefactoringController,
	#superclass : #GtMoveTemporaryRefactoringController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Variables'
}

{ #category : #'as yet unclassified' }
GtMoveTemporaryToOuterScopeRefactoringController >> refactoring [
	| model class selector |
	model := self createRefactoringModel.
	class := model classFor: self behavior.
	selector := self selector.
	^ GtMoveTemporaryToOuterScopeRefactoring
		model: model
		moveVariableAt: self variableNode sourceInterval
		in: selector
		class: class
]

{ #category : #'as yet unclassified' }
GtMoveTemporaryToOuterScopeRefactoringController >> refactoringName [
	^ 'Move ' , self variableNode source , ' to outer scope'
]
