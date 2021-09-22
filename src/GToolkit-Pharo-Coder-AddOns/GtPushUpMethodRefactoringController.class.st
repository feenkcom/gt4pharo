Class {
	#name : 'GtPushUpMethodRefactoringController',
	#superclass : 'GtMethodRefactoringController',
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : 'accessing' }
GtPushUpMethodRefactoringController >> refactoring [
	| model |
	model := self createRefactoringModel.
	^ RBPullUpMethodRefactoring
		  model: model
		  pullUp: { self methodSelector }
		  from: (model classFor: self methodClass)
]

{ #category : 'accessing' }
GtPushUpMethodRefactoringController >> refactoringName [
	^ 'Push up method #' , self methodSelector
]
