Class {
	#name : #GtSnippetConvertCascadesToStatementsController,
	#superclass : #GtConvertCascadesToStatementsController,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #accessing }
GtSnippetConvertCascadesToStatementsController >> refactoring [
	| refactoring model |
	model := self createSnippetRefactoringModel.
	refactoring := GtConvertCascadesToStatementsRefactoring
			model: model
			convert: (self snippetIntervalFor: node sourceInterval)
			inMethod: self snippetSelector
			forClass: self snippetClass.
	temporaryCreated := false.
	refactoring
		setOption: #receiverName
		toUse: [ :ref | 
			temporaryCreated := true.
			receiverName ].
	^ refactoring
]

{ #category : #accessing }
GtSnippetConvertCascadesToStatementsController >> safelyExecute [
	| refactoring sourceCode |
	refactoring := self refactoring.
	[ refactoring primitiveExecute ] on: RBRefactoringError do: [ :ex | ^ self ].
	sourceCode := self refactoredSnippetCodeFrom: refactoring.
	self setText: sourceCode.
	temporaryCreated ifTrue: [ self installRenameAction ]
]
