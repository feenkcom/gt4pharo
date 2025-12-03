Class {
	#name : #GtRBRefactoringSupportExamples,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-Coder-Examples-Refactorings - Support'
}

{ #category : #'as yet unclassified' }
GtRBRefactoringSupportExamples >> checkAbstractGetter [
	<gtExample>
	| model |
	model := self checkClassGetterMethod.
	(RBAbstractInstanceVariableRefactoring
		model: model
		variable: 'array'
		class: (model classFor: OrderedCollection)) primitiveExecute.
	self
		assert: (model changes gtAllChanges
				anySatisfy: [ :each | 
					(each isKindOf: RBAddMethodChange)
						and: [ each changeClassName = #OrderedCollection
								and: [ each selector isUnary
										and: [ (each changeClass includesSelector: each selector) not ] ] ] ]).
	^ model
]

{ #category : #'as yet unclassified' }
GtRBRefactoringSupportExamples >> checkClassGetterMethod [
	<gtExample>
	| model oc sc |
	model := RBNamespace new.
	oc := model classFor: OrderedCollection.
	sc := model classFor: SortedCollection.
	sc compile: 'collector ^self instVarAt: 1' classified: #junk.
	self assert: (oc getterMethodFor: 'array') isNil.
	^ model
]
