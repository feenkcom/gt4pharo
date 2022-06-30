Class {
	#name : #GtRenameClassVariableAdviceAction,
	#superclass : #GtRenameVariableAdviceAction,
	#category : #'GToolkit-Pharo-Coder-AddOns-Advice'
}

{ #category : #executing }
GtRenameClassVariableAdviceAction >> renameRefactoringClass [
	^ RBRenameClassVariableRefactoring
]
