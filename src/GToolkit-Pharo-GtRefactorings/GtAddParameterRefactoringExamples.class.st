Class {
	#name : #GtAddParameterRefactoringExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-GtRefactorings-Examples'
}

{ #category : #private }
GtAddParameterRefactoringExamples >> addParameterSender [
	"A sender of #addParameterTarget, for #addParameterWithSelfInDefaultValue"

	^ self addParameterTarget
]

{ #category : #private }
GtAddParameterRefactoringExamples >> addParameterTarget [
	"The method of #addParameterWithSelfInDefaultValue"

	^ 1
]

{ #category : #examples }
GtAddParameterRefactoringExamples >> addParameterWithSelfInDefaultValue [
	"Adding a parameter to a method with senders, with a default value that uses self: RB variable names are Symbols"

	<gtExample>
	<return: #GtAddParameterRefactoring>
	| model refactoring |
	model := Smalltalk createRbNamespace onEnvironment: RBBrowserEnvironment new.
	refactoring := GtAddParameterRefactoring
			model: model
			addParameterToMethod: #addParameterTarget
			in: (model classFor: self class)
			newSelector: #addParameterTarget:
			permutation: #(-1)
			newArgs: {RBArgumentName name: 'anObject' value: 'self yourself'}.
	refactoring shouldReplaceExpressions: false.
	refactoring primitiveExecute.
	self assert: refactoring changes changes notEmpty.
	^ refactoring
]
