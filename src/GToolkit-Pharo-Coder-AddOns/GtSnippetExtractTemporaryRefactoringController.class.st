Class {
	#name : #GtSnippetExtractTemporaryRefactoringController,
	#superclass : #GtExtractTemporaryRefactoringController,
	#instVars : [
		'hasTemps'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Variables'
}

{ #category : #accessing }
GtSnippetExtractTemporaryRefactoringController >> behavior [
	^ nil class
]

{ #category : #private }
GtSnippetExtractTemporaryRefactoringController >> createRefactoringModel [
	| model |
	model := RBClassModelFactory rbNamespace onEnvironment: RBBrowserEnvironment new.
	self compileSnippetMethodIn: model.
	^ model
]

{ #category : #accessing }
GtSnippetExtractTemporaryRefactoringController >> selector [
	^ self snippetSelector
]

{ #category : #accessing }
GtSnippetExtractTemporaryRefactoringController >> sourceInterval [
	| interval |
	interval := super sourceInterval.
	^ interval first + 2 to: interval last + 2
]

{ #category : #executing }
GtSnippetExtractTemporaryRefactoringController >> updatedSourceFrom: model [
	| source ast |
	source := super updatedSourceFrom: model.
	ast := (RBParser parseMethod: source) body.
	ast removeTemporaryNamed: tempName.
	^ ast formattedCode
]
