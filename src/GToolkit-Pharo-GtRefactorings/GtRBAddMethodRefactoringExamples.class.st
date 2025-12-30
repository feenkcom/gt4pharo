Class {
	#name : #GtRBAddMethodRefactoringExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-GtRefactorings-Examples'
}

{ #category : #examples }
GtRBAddMethodRefactoringExamples >> checkAddingToNewClass [
	<gtExample>
	| namespace refactorings |
	namespace := GtRBNamespace new.
	refactorings := {GtRBAddClassWithVarsRefactoring
				model: namespace
				addClass: #Asdf
				superclass: #Object
				subclasses: #()
				category: #Asdf.
			GtRBAddMethodRefactoring
				model: namespace
				sourceCode: 'asdf ^ 42'
				in: #Asdf
				withProtocol: #access}.
	refactorings do: #primitiveExecute.
	self assert: namespace changes changesSize equals: 2.
	^ namespace
]
