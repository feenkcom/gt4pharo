Class {
	#name : #GtPushDownInstanceVariableRefactoringController,
	#superclass : #GtVariableRefactoringController,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Variables'
}

{ #category : #accessing }
GtPushDownInstanceVariableRefactoringController >> refactoring [
	| aModel aClass |
	
	aModel := self createRefactoringModel.
	aClass := aModel classFor: sourceCoderViewModel behavior.

	^ GtPushDownInstanceVariableRefactoring 
		model: aModel
		variable: self variableName
		class: (aClass whoDefinesInstanceVariable: self variableName)
]

{ #category : #accessing }
GtPushDownInstanceVariableRefactoringController >> refactoringName [
	^ 'Push down variable ' , variableNode variableName
]
