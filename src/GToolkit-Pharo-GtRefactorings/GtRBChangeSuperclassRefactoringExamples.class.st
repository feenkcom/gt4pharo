Class {
	#name : #GtRBChangeSuperclassRefactoringExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-GtRefactorings-Examples'
}

{ #category : #'as yet unclassified' }
GtRBChangeSuperclassRefactoringExamples >> changeSuperclass [
	<gtExample>
	| namespace refactorings |
	namespace := GtRBNamespace new.
	refactorings := {GtRBChangeSuperclassRefactoring
				model: namespace
				changeSuperclassOf: #Point
				to: #Association}.
	refactorings do: #primitiveExecute.
	self
		assert: (namespace classObjectFor: Point) superclass
		equals: (namespace classObjectFor: Association).
	self assert: namespace changes changesSize equals: 1.
	^ namespace
]

{ #category : #'as yet unclassified' }
GtRBChangeSuperclassRefactoringExamples >> changeSuperclassOnNewClass [
	<gtExample>
	| namespace refactorings |
	namespace := GtRBNamespace new.
	refactorings := {GtRBAddClassWithVarsRefactoring
				model: namespace
				addClass: #Asdf
				superclass: #Object
				subclasses: #()
				category: #Asdf.
			GtRBChangeSuperclassRefactoring
				model: namespace
				changeSuperclassOf: #Asdf
				to: #Association}.
	refactorings do: #primitiveExecute.
	self
		assert: (namespace classObjectFor: #Asdf) superclass
		equals: (namespace classObjectFor: #Association).
	self assert: namespace changes changesSize equals: 2.
	self assert: namespace changes gtAllChanges last packageName equals: #Asdf.
	^ namespace
]

{ #category : #'as yet unclassified' }
GtRBChangeSuperclassRefactoringExamples >> changeSuperclassToNewClass [
	<gtExample>
	| namespace refactorings |
	namespace := GtRBNamespace new.
	refactorings := {GtRBAddClassWithVarsRefactoring
				model: namespace
				addClass: #Asdf
				superclass: #Object
				subclasses: #()
				category: #Asdf.
			GtRBChangeSuperclassRefactoring
				model: namespace
				changeSuperclassOf: #Point
				to: #Asdf}.
	refactorings do: #primitiveExecute.
	self
		assert: (namespace classObjectFor: Point) superclass
		equals: (namespace classObjectFor: #Asdf).
	self assert: namespace changes changesSize equals: 2.
	^ namespace
]
