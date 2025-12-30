Class {
	#name : #GtPushUpMethodRefactoringExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-AddOns-Examples'
}

{ #category : #'as yet unclassified' }
GtPushUpMethodRefactoringExamples >> pushUpUsingNewClasses [
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
			GtRBAddMethodRefactoring
				model: namespace
				sourceCode: 'asdf ^ 42'
				in: #Fdsa
				withProtocol: #access.
			GtPushUpMethodRefactoring
				model: namespace
				pullUp: #(#asdf)
				from: #Fdsa
				to: #Asdf}.
	refactorings do: #primitiveExecute.
	self assert: ((namespace classObjectFor: #Asdf) directlyDefinesMethod: #asdf).
	self
		assert: ((namespace classObjectFor: #Fdsa) directlyDefinesMethod: #asdf) not.
	self assert: namespace changes changesSize equals: 5.
	^ namespace
]
