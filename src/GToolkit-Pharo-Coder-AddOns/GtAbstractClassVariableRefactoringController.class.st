Class {
	#name : #GtAbstractClassVariableRefactoringController,
	#superclass : #GtVariableRefactoringController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Variables'
}

{ #category : #accessing }
GtAbstractClassVariableRefactoringController >> refactoring [
	| aModel aClass |
	
	aModel := self createRefactoringModel.
	aClass := (aModel classFor: sourceCoderViewModel behavior) instanceSide.

	^ RBAbstractClassVariableRefactoring
		model: aModel
		variable: self variableName
		class: (aClass whoDefinesClassVariable: self variableName)
]

{ #category : #accessing }
GtAbstractClassVariableRefactoringController >> refactoringName [
	^ 'Abstract class variable {1}' format: { self variableName }
]
