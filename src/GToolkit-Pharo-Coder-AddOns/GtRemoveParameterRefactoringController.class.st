Class {
	#name : 'GtRemoveParameterRefactoringController',
	#superclass : 'GtVariableRefactoringController',
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Variables'
}

{ #category : 'accessing' }
GtRemoveParameterRefactoringController >> refactoring [
	| aModel aClass |
	
	aModel := self createRefactoringModel.
	aClass := (aModel classFor: sourceCoderViewModel behavior) instanceSide.

	^ RBRemoveParameterRefactoring
		model: aModel
		removeParameter: self variableName
		in: aClass
		selector: sourceCoderViewModel coderModel currentSelector.
]

{ #category : 'accessing' }
GtRemoveParameterRefactoringController >> refactoringName [
	^ 'Remove parameter {1}' format: { self variableName }
]
