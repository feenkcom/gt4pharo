Class {
	#name : #GtRBSilentlyAddMethodRefactoring,
	#superclass : #RBAddMethodRefactoring,
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #preconditions }
GtRBSilentlyAddMethodRefactoring >> prepareForExecution [
	| selector method |
	method := RBParser
			parseMethod: source
			onError: [ :string :position | ^ self refactoringFailure: 'The sources could not be parsed' ].
	selector := method selector.
	selector isNil ifTrue: [ self refactoringFailure: 'Invalid source.' ].
	super prepareForExecution
]
