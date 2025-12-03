Class {
	#name : #GtPushUpMethodRefactoringController,
	#superclass : #GtMethodRefactoringController,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #testing }
GtPushUpMethodRefactoringController >> previewDisplaysImmediately [
	^ true
]

{ #category : #accessing }
GtPushUpMethodRefactoringController >> refactoring [
	| model refactoring |
	model := self createRefactoringModel.
	refactoring := GtPushUpMethodRefactoring
		               model: model
		               pullUp: { self methodSelector }
		               from: (model classFor: self methodClass).
	refactoring gtDefaultToRemoveDuplicates.
	^ refactoring
]

{ #category : #accessing }
GtPushUpMethodRefactoringController >> refactoringName [
	^ 'Push up method #' , self methodSelector
]
