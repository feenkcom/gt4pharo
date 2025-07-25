Class {
	#name : #GtCreateInstanceVariableAccessorsRefactoringController,
	#superclass : #GtVariableRefactoringController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Variables'
}

{ #category : #accessing }
GtCreateInstanceVariableAccessorsRefactoringController >> refactoring [
	| aModel aClass |
	
	aModel := self createRefactoringModel.
	aClass := (aModel classFor: sourceCoderViewModel behavior) instanceSide.

	^ RBCreateAccessorsForVariableRefactoring
		model: aModel
		variable: self variableName
		class: (aClass whoDefinesInstanceVariable: self variableName)
		classVariable: false
]

{ #category : #accessing }
GtCreateInstanceVariableAccessorsRefactoringController >> refactoringName [
	^ 'Create accessors for instance variable {1}' format: { self variableName }
]
