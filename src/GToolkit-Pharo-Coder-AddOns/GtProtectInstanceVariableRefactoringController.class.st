Class {
	#name : 'GtProtectInstanceVariableRefactoringController',
	#superclass : 'GtVariableRefactoringController',
	#category : 'GToolkit-Pharo-Coder-AddOns-Variables refactoring'
}

{ #category : 'accessing' }
GtProtectInstanceVariableRefactoringController >> refactoring [
	| aModel aClass |
	
	aModel := self createRefactoringModel.
	aClass := aModel classFor: sourceCoderViewModel behavior.

	^ RBProtectInstanceVariableRefactoring
		model: aModel
		variable: self variableName
		class: (aClass whoDefinesClassVariable: self variableName)
]

{ #category : 'accessing' }
GtProtectInstanceVariableRefactoringController >> refactoringName [
	^ 'Protect instance variable {1}' format: { self variableName }
]
