Class {
	#name : #GtRBAddClassWithVarsRefactoringExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-GtRefactorings-Examples'
}

{ #category : #examples }
GtRBAddClassWithVarsRefactoringExamples >> checkWithNewClasses [
	<gtExample>
	| namespace refactorings |
	namespace := GtRBNamespace new.
	refactorings := {GtRBAddClassWithVarsRefactoring
				model: namespace
				addClass: #Asdf
				superclass: #Object
				subclasses: #()
				category: #Asdf.
			GtRBAddClassWithVarsRefactoring
				model: namespace
				addClass: #Fdsa
				superclass: #Asdf
				subclasses: #()
				category: #Asdf.
			GtRBAddClassWithVarsRefactoring
				model: namespace
				addClass: #SDAF
				superclass: #Asdf
				subclasses: #(Fdsa)
				category: #Asdf}.
	refactorings do: #primitiveExecute.
	self assert: namespace changes changesSize equals: 4.
	self
		assert: (namespace classObjectFor: #SDAF) superclass
		equals: (namespace classObjectFor: #Asdf).
	self
		assert: (namespace classObjectFor: #Fdsa) superclass
		equals: (namespace classObjectFor: #SDAF).
	^ namespace
]

{ #category : #examples }
GtRBAddClassWithVarsRefactoringExamples >> createClassWithInstanceSlots [
	<gtExample>
	| ns r |
	ns := GtRBNamespace new.
	r := (GtRBAddClassWithVarsRefactoring
			model: ns
			addClass: #Something
			superclass: #Object
			subclasses: {}
			category: 'Somewhere' asSymbol)
			instanceVariableNames: {'first'.
					'second'}.
	r primitiveExecute.
	self assert: ns changes changesSize equals: 1.
	^ ns
]
