Class {
	#name : #GtSnippetExtractTemporaryRefactoringController,
	#superclass : #GtExtractTemporaryRefactoringController,
	#instVars : [
		'hasTemps'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Variables'
}

{ #category : #accessing }
GtSnippetExtractTemporaryRefactoringController >> behavior [
	^self snippetClass
]

{ #category : #private }
GtSnippetExtractTemporaryRefactoringController >> createRefactoringModel [
	^ self createSnippetRefactoringModel
]

{ #category : #accessing }
GtSnippetExtractTemporaryRefactoringController >> selector [
	^ self snippetSelector
]

{ #category : #accessing }
GtSnippetExtractTemporaryRefactoringController >> sourceInterval [
	^ self snippetIntervalFor: super sourceInterval
]

{ #category : #executing }
GtSnippetExtractTemporaryRefactoringController >> updatedSourceFrom: model [
	| source ast |
	source := super updatedSourceFrom: model.
	ast := (RBParser parseMethod: source) body.
	ast removeTemporaryNamed: tempName.
	^ ast formattedCode
]
