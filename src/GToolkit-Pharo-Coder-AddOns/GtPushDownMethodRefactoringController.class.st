Class {
	#name : #GtPushDownMethodRefactoringController,
	#superclass : #GtMethodRefactoringController,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #testing }
GtPushDownMethodRefactoringController >> previewDisplaysImmediately [
	^ true
]

{ #category : #accessing }
GtPushDownMethodRefactoringController >> refactoring [
	| model |
	model := self createRefactoringModel.
	^ GtRBPushDownMethodRefactoring
		model: model
		pushDown: {self methodSelector}
		from: (self
				forPharo12AndNewer: [ (model classFor: self methodClass) name ]
				forPharo11: [ model classFor: self methodClass ])
]

{ #category : #accessing }
GtPushDownMethodRefactoringController >> refactoringName [
	^ 'Push down method #' , self methodSelector
]
