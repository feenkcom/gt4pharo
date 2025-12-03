Class {
	#name : #GtRenameInstanceVariableAdviceAction,
	#superclass : #GtRenameVariableAdviceAction,
	#category : 'GToolkit-Pharo-Coder-AddOns-ObjectAdvices'
}

{ #category : #executing }
GtRenameInstanceVariableAdviceAction >> renameRefactoringClass [
	^ GtRenameInstanceVariableRefactoring
]
