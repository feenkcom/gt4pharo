Class {
	#name : #GtSnippetSplitCascadesController,
	#superclass : #GtSplitCascadesController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Coder'
}

{ #category : #accessing }
GtSnippetSplitCascadesController >> refactoring [
	| refactoring model |
	model := self createSnippetRefactoringModel.
	refactoring := GtSplitCascadesRefactoring
			model: model
			splitAt: (node parent semicolons
					at: (node parent messages identityIndexOf: node) - 1) startPosition
					+ self snippetSelector size + 1
			inMethod: self snippetSelector
			forClass: (model classFor: self snippetClass).
	temporaryCreated := false.
	refactoring
		setOption: #receiverName
		toUse: [ :ref | 
			temporaryCreated := true.
			receiverName ].
	^ refactoring
]

{ #category : #executing }
GtSnippetSplitCascadesController >> safelyExecute [
	| refactoring newSource |
	refactoring := self refactoring.
	sourceCoderViewModel selectNone.
	[ refactoring primitiveExecute ] on: RBRefactoringError do: [ :ex | ^ false ].
	newSource := self refactoredSnippetCodeFrom: refactoring.
	sourceCoderViewModel sourceText asString = newSource
		ifFalse: [ self setText: newSource asText ].
	temporaryCreated ifTrue: [ self installRenameAction ]
]
