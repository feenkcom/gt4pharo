Class {
	#name : #GtRenameClassVariableAdviceAction,
	#superclass : #GtRenameVariableAdviceAction,
	#category : 'GToolkit-Pharo-Coder-AddOns-ObjectAdvices'
}

{ #category : #executing }
GtRenameClassVariableAdviceAction >> renameRefactoringClass [
	^ RBRenameClassVariableRefactoring
]
