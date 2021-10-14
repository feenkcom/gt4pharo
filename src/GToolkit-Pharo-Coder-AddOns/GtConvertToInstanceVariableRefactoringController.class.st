Class {
	#name : #GtConvertToInstanceVariableRefactoringController,
	#superclass : #GtVariableRefactoringController,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Variables'
}

{ #category : #accessing }
GtConvertToInstanceVariableRefactoringController >> refactoring [
	| aModel aClass |
	
	aModel := self createRefactoringModel.
	aClass := aModel classFor: sourceCoderViewModel behavior.

	^ RBTemporaryToInstanceVariableRefactoring
		model: aModel
		class: aClass 
		selector: variableNode methodNode selector
		variable: self variableName
]

{ #category : #accessing }
GtConvertToInstanceVariableRefactoringController >> refactoringName [
	^ 'Convert {1} to instance variable' format: { self variableName }
]
