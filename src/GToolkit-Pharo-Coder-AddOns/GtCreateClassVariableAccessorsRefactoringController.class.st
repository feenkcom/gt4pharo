Class {
	#name : #GtCreateClassVariableAccessorsRefactoringController,
	#superclass : #GtVariableRefactoringController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Variables'
}

{ #category : #accessing }
GtCreateClassVariableAccessorsRefactoringController >> refactoring [
	| aModel aClass |
	
	aModel := self createRefactoringModel.
	aClass := aModel classFor: sourceCoderViewModel behavior.

	^ RBCreateAccessorsForVariableRefactoring
		model: aModel
		variable: self variableName
		class: (aClass whoDefinesClassVariable: self variableName)
		classVariable: true
]

{ #category : #accessing }
GtCreateClassVariableAccessorsRefactoringController >> refactoringName [
	^ 'Create accessors for class variable {1}' format: { self variableName }
]
