Extension { #name : #RBAbstractVariablesRefactoring }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBAbstractVariablesRefactoring >> gtHasClassVariablesToAbstract [
	^ classVarReaders notEmpty or: [ classVarWriters notEmpty ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBAbstractVariablesRefactoring >> gtHasInstanceVariablesToAbstract [
	^ instVarWriters notEmpty
		or: [ instVarReaders notEmpty and: [ self canSplitLifetimes not ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBAbstractVariablesRefactoring >> gtHasVariablesToAbstract [
	^ self gtHasInstanceVariablesToAbstract
		or: [ self gtHasClassVariablesToAbstract ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBAbstractVariablesRefactoring >> gtInstanceVariableReaders [
	^ instVarReaders
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBAbstractVariablesRefactoring >> gtInstanceVariableWriters [
	^ instVarWriters
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBAbstractVariablesRefactoring >> gtOnlyReadVariables [
	^ instVarReaders reject: [ :each | instVarWriters includes: each ]
]
