Class {
	#name : #GtMoveVariableRefactoringController,
	#superclass : #GtVariableRefactoringController,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Variables'
}

{ #category : #accessing }
GtMoveVariableRefactoringController >> refactoring [
	| model |
	model := self createRefactoringModel..
	^ RBMoveVariableDefinitionRefactoring
		  model: model
		  bindTight: variableNode sourceInterval
		  in: (model classFor: sourceCoderViewModel behavior)
		  selector: sourceCoderViewModel selector
]

{ #category : #accessing }
GtMoveVariableRefactoringController >> refactoringName [
	^ 'Move variable to inner scope'
]

{ #category : #executing }
GtMoveVariableRefactoringController >> safelyExecute [
	| refactoring newSource |
	refactoring := self refactoring.
	sourceCoderViewModel selectNone.
	[ refactoring primitiveExecute ]
		on: RBRefactoringError
		do: [ :ex | ^ false ].
	newSource := (refactoring model classFor:
		              sourceCoderViewModel behavior) sourceCodeFor:
		             sourceCoderViewModel selector.
	sourceCoderViewModel sourceText asString = newSource ifFalse: [ 
		self setText: newSource asText ]
]
