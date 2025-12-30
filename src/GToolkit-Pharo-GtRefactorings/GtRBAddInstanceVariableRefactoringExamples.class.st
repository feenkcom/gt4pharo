Class {
	#name : #GtRBAddInstanceVariableRefactoringExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-GtRefactorings-Examples'
}

{ #category : #examples }
GtRBAddInstanceVariableRefactoringExamples >> checkAddingToNewClass [
	<gtExample>
	| namespace refactorings |
	namespace := GtRBNamespace new.
	refactorings := {GtRBAddClassWithVarsRefactoring
				model: namespace
				addClass: #Asdf
				superclass: #Object
				subclasses: #()
				category: #Asdf.
			GtRBAddInstanceVariableRefactoring
				model: namespace
				variable: 'aaa'
				class: #Asdf}.
	refactorings do: #primitiveExecute.
	self assert: namespace changes changesSize equals: 2.
	^ namespace
]
