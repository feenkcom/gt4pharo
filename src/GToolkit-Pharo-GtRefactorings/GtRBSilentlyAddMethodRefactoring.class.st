Class {
	#name : #GtRBSilentlyAddMethodRefactoring,
	#superclass : #RBAddMethodRefactoring,
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #preconditions }
GtRBSilentlyAddMethodRefactoring >> preconditions [
	| selector method |
	method := RBParser parseMethod: source
				onError: 
					[:string :position | 
					^RBCondition 
						withBlock: [self refactoringFailure: 'The sources could not be parsed']].
	selector := method selector.
	selector isNil ifTrue: [self refactoringFailure: 'Invalid source.'].
	^ RBCondition withBlock: [ true ]
]
