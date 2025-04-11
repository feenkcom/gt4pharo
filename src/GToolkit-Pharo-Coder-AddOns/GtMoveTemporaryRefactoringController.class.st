Class {
	#name : #GtMoveTemporaryRefactoringController,
	#superclass : #GtVariableRefactoringController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Variables'
}

{ #category : #'as yet unclassified' }
GtMoveTemporaryRefactoringController >> safelyExecute [
	| refactoring newSource |
	refactoring := self refactoring.
	sourceCoderViewModel selectNone.
	[ refactoring primitiveExecute ] on: RBRefactoringError do: [ :ex | ^ false ].
	newSource := (refactoring model classFor: sourceCoderViewModel behavior)
			sourceCodeFor: sourceCoderViewModel selector.
	sourceCoderViewModel sourceText asString = newSource
		ifFalse: [ self setText: newSource asText ]
]
