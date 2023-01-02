Class {
	#name : #GtSnippetConvertCascadesToStatementsController,
	#superclass : #GtConvertCascadesToStatementsController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #private }
GtSnippetConvertCascadesToStatementsController >> createRefactoringModel [
	| model |
	model := RBClassModelFactory rbNamespace onEnvironment: RBBrowserEnvironment new.
	self compileSnippetMethodIn: model.
	^ model
]

{ #category : #accessing }
GtSnippetConvertCascadesToStatementsController >> refactoring [
	| refactoring model |
	model := self createRefactoringModel.
	refactoring := GtConvertCascadesToStatementsRefactoring
			model: model
			convert: (node startPosition + self snippetSelector size + 1
					to: node stopPosition + self snippetSelector size + 1)
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
	| refactoring ast |
	refactoring := self refactoring.
	[ refactoring primitiveExecute ] on: RBRefactoringError do: [ :ex | ^ self ].
	ast := ((refactoring model classFor: self snippetClass) methodFor: self snippetSelector) ast body.
	ast temporaryNames do: [ :each | ast removeTemporaryNamed: each ].
	self setText: ast formattedCode.
	temporaryCreated ifTrue: [ self installRenameAction ]
]
