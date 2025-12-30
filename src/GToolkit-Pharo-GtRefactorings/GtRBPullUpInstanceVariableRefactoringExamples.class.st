Class {
	#name : #GtRBPullUpInstanceVariableRefactoringExamples,
	#superclass : #GtRBPullUpInstanceVariableRefactoring,
	#category : #'GToolkit-Pharo-GtRefactorings-Examples'
}

{ #category : #examples }
GtRBPullUpInstanceVariableRefactoringExamples >> pullUpWithNewClasses [
	<gtExample>
	| namespace refactorings |
	namespace := GtRBNamespace new.
	refactorings := {GtRBAddClassWithVarsRefactoring
				model: namespace
				addClass: #Asdf
				superclass: #Object
				subclasses: #()
				category: #Asdf.
			(GtRBAddClassWithVarsRefactoring
				model: namespace
				addClass: #Fdsa
				superclass: #Asdf
				subclasses: #()
				category: #Asdf)
				instanceVariableNames: #('aaa');
				yourself.
			GtRBPullUpInstanceVariableRefactoring
				model: namespace
				variable: 'aaa'
				class: #Asdf}.
	refactorings do: #primitiveExecute.
	self assert: namespace changes changesSize equals: 4.
	self
		assert: (namespace classObjectFor: #Asdf) instanceVariableNames asArray
		equals: #('aaa').
	self
		assert: (namespace classObjectFor: #Fdsa) instanceVariableNames asArray
		equals: #().
	^ namespace
]
