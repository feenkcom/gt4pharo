Class {
	#name : #GtProtectInstanceVariableRefactoringController,
	#superclass : #GtVariableRefactoringController,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Variables'
}

{ #category : #accessing }
GtProtectInstanceVariableRefactoringController >> refactoring [
	| aModel aClass |
	
	aModel := self createRefactoringModel.
	aClass := aModel classFor: sourceCoderViewModel behavior.

	^ RBProtectInstanceVariableRefactoring
		model: aModel
		variable: self variableName
		class: (aClass whoDefinesInstanceVariable: self variableName)
]

{ #category : #accessing }
GtProtectInstanceVariableRefactoringController >> refactoringName [
	^ 'Protect instance variable {1}' format: { self variableName }
]
