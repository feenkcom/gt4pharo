Class {
	#name : #GtPushUpInstanceVariableRefactoringController,
	#superclass : #GtVariableRefactoringController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Variables'
}

{ #category : #accessing }
GtPushUpInstanceVariableRefactoringController >> refactoring [
	| aModel aClass |
	
	aModel := self createRefactoringModel.
	aClass := aModel classFor: sourceCoderViewModel behavior.

	^ RBPullUpInstanceVariableRefactoring 
		model: aModel
		variable: self variableName
		class: (aClass whoDefinesInstanceVariable: self variableName) superclass
]

{ #category : #accessing }
GtPushUpInstanceVariableRefactoringController >> refactoringName [
	^ 'Push up variable ' , variableNode variableName
]
