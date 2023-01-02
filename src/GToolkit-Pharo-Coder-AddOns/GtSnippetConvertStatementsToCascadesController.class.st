Class {
	#name : #GtSnippetConvertStatementsToCascadesController,
	#superclass : #GtConvertStatementsToCascadesController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #accessing }
GtSnippetConvertStatementsToCascadesController >> createRefactoringModel [
	| model |
	model := RBClassModelFactory rbNamespace onEnvironment: RBBrowserEnvironment new.
	self compileSnippetMethodIn: model.
	^ model
]

{ #category : #accessing }
GtSnippetConvertStatementsToCascadesController >> refactoring [
	| refactoring model |
	model := self createRefactoringModel.
	refactoring := GtConvertStatementsToCascadesRefactoring
			model: model
			convert: (nodes first startPosition + 2 to: nodes last stopPosition + 2)
			inMethod: self snippetSelector
			forClass: self snippetClass.
	^ refactoring
]

{ #category : #accessing }
GtSnippetConvertStatementsToCascadesController >> safelyExecute [
	| refactoring ast |
	refactoring := self refactoring.
	sourceCoderViewModel selectNone.
	[ refactoring primitiveExecute ] on: RBRefactoringError do: [ :ex | ^ false ].
	ast := ((refactoring model classFor: self snippetClass)
			methodFor: self snippetSelector) ast body.
	ast temporaryNames do: [ :each | ast removeTemporaryNamed: each ].
	self setText: ast formattedCode
]
