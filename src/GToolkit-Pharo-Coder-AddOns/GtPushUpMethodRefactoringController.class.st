Class {
	#name : 'GtPushUpMethodRefactoringController',
	#superclass : 'GtMethodRefactoringController',
	#category : 'GToolkit-Pharo-Coder-AddOns-Variables refactoring'
}

{ #category : 'accessing' }
GtPushUpMethodRefactoringController >> refactoring [
	| model |
	model := self createModel.
	^ RBPullUpMethodRefactoring
		  model: model
		  pullUp: { self methodSelector }
		  from: (model classFor: self methodClass)
]

{ #category : 'accessing' }
GtPushUpMethodRefactoringController >> refactoringName [
	^ 'Push up method #' , self methodSelector
]
