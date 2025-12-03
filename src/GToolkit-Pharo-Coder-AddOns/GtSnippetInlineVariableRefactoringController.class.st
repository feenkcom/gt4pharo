Class {
	#name : #GtSnippetInlineVariableRefactoringController,
	#superclass : #GtPharoSourceCoderRefactoringController,
	#instVars : [
		'node'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #accessing }
GtSnippetInlineVariableRefactoringController >> node: aNode [
	node := aNode 
]

{ #category : #accessing }
GtSnippetInlineVariableRefactoringController >> refactoring [
	| aModel |
	aModel := self createSnippetRefactoringModel.

	^ GtInlineSnippetVariableRefactoring
		model: aModel
		inline: (self snippetIntervalFor: node sourceInterval)
		from: self snippetSelector
		in: (aModel classFor: self snippetClass)
]

{ #category : #accessing }
GtSnippetInlineVariableRefactoringController >> refactoringName [
	^ 'Inline temporary variable'
]

{ #category : #accessing }
GtSnippetInlineVariableRefactoringController >> safelyExecute [
	| refactoring |
	refactoring := self refactoring.
	[ refactoring primitiveExecute ] on: RBRefactoringError do: [ :ex | ^ self ].
	self setText: (self refactoredSnippetCodeFrom: refactoring)
]
