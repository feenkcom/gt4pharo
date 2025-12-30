Class {
	#name : #GtRBPushDownMethodRefactoringExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-AddOns-Examples'
}

{ #category : #'as yet unclassified' }
GtRBPushDownMethodRefactoringExamples >> pushDownUsingNewClasses [
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
				in: #Asdf
				withProtocol: #access.
			GtRBPushDownMethodRefactoring
				model: namespace
				pushDown: #(#asdf)
				from: #Asdf}.
	refactorings do: #primitiveExecute.
	self
		assert: ((namespace classObjectFor: #Asdf) directlyDefinesMethod: #asdf) not.
	self assert: ((namespace classObjectFor: #Fdsa) directlyDefinesMethod: #asdf).
	self assert: namespace changes changesSize equals: 5.
	^ namespace
]

{ #category : #'as yet unclassified' }
GtRBPushDownMethodRefactoringExamples >> pushDownUsingNewClassesAndDestinationClasses [
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
				in: #Asdf
				withProtocol: #access.
			GtRBPushDownMethodRefactoring
				model: namespace
				pushDown: #(#asdf)
				from: #Asdf
				in: #(Fdsa)}.
	refactorings do: #primitiveExecute.
	self
		assert: ((namespace classObjectFor: #Asdf) directlyDefinesMethod: #asdf) not.
	self assert: ((namespace classObjectFor: #Fdsa) directlyDefinesMethod: #asdf).
	self assert: namespace changes changesSize equals: 5.
	^ namespace
]
