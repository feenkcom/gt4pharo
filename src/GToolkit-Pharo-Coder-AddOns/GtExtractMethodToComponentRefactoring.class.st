Class {
	#name : #GtExtractMethodToComponentRefactoring,
	#superclass : #RBExtractMethodToComponentRefactoring,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #accessing }
GtExtractMethodToComponentRefactoring >> moveMethod [
	| variable refactoring |
	variable := self
			selectVariableToMoveMethodTo: extractedMethodSelector
			class: class.
	variable ifNil: [ self refactoringFailure: 'Did not extract method' ].
	refactoring := GtMoveMethodRefactoring
			model: self model
			selector: extractedMethodSelector
			class: class
			variable: variable.
	self performCompositeRefactoring: refactoring
]

{ #category : #accessing }
GtExtractMethodToComponentRefactoring >> transform [
	super transform.
	self gtCleanupChanges
]
