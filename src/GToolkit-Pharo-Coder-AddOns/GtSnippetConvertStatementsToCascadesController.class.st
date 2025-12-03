Class {
	#name : #GtSnippetConvertStatementsToCascadesController,
	#superclass : #GtConvertStatementsToCascadesController,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #accessing }
GtSnippetConvertStatementsToCascadesController >> refactoring [
	| refactoring model |
	model := self createSnippetRefactoringModel.
	refactoring := GtConvertStatementsToCascadesRefactoring
			model: model
			convert: (self
					snippetIntervalFor: (nodes first startPosition to: nodes last stopPosition))
			inMethod: self snippetSelector
			forClass: self snippetClass.
	^ refactoring
]

{ #category : #accessing }
GtSnippetConvertStatementsToCascadesController >> safelyExecute [
	| refactoring |
	refactoring := self refactoring.
	sourceCoderViewModel selectNone.
	[ refactoring primitiveExecute ] on: RBRefactoringError do: [ :ex | ^ false ].
	self setText: (self refactoredSnippetCodeFrom: refactoring)
]
