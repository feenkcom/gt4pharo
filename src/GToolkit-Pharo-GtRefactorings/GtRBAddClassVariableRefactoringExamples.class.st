Class {
	#name : #GtRBAddClassVariableRefactoringExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-GtRefactorings-Examples'
}

{ #category : #examples }
GtRBAddClassVariableRefactoringExamples >> checkAddingToNewClass [
	<gtExample>
	| namespace refactorings |
	namespace := GtRBNamespace new.
	refactorings := {GtRBAddClassWithVarsRefactoring
				model: namespace
				addClass: #Asdf
				superclass: #Object
				subclasses: #()
				category: #Asdf.
			GtRBAddClassVariableRefactoring
				model: namespace
				variable: 'Aaa'
				class: #Asdf}.
	refactorings do: #primitiveExecute.
	self assert: namespace changes changesSize equals: 2.
	^ namespace
]
