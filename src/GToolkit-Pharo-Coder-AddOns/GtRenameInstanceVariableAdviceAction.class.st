Class {
	#name : #GtRenameInstanceVariableAdviceAction,
	#superclass : #GtRenameVariableAdviceAction,
	#category : #'GToolkit-Pharo-Coder-AddOns-Advice'
}

{ #category : #executing }
GtRenameInstanceVariableAdviceAction >> renameRefactoringClass [
	^ RBRenameInstanceVariableRefactoring
]
