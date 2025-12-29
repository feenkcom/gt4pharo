Class {
	#name : #GtRBAddClassWithVarsRefactoringExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-GtRefactorings-Examples'
}

{ #category : #'as yet unclassified' }
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
