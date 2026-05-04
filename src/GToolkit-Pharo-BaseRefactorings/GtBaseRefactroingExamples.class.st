Class {
	#name : #GtBaseRefactroingExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-BaseRefactorings-Examples'
}

{ #category : #'create accessors' }
GtBaseRefactroingExamples >> failCreateAccessorsOnMissingVariable [
	<gtExample>
	| refactoring |
	refactoring := RBCreateAccessorsForVariableRefactoring
			instanceVariable: 'foo'
			class: self class.
	self shouldThrowError: refactoring.
	^ refactoring
]

{ #category : #'create accessors' }
GtBaseRefactroingExamples >> failCreateAccessorsWithBadInitialization [
	<gtExample>
	| refactoring |
	refactoring := RBCreateAccessorsWithLazyInitializationForVariableRefactoring
			variable: 'array'
			class: OrderedCollection
			classVariable: false
			defaultValue: '#( 43'.
	self shouldThrowError: refactoring.
	^ refactoring
]

{ #category : #'as yet unclassified' }
GtBaseRefactroingExamples >> failRemoveUnknownClass [
	<gtExample>
	| refactoring |
	refactoring := RBRemoveClassRefactoring classNames: #(AsdfFoo).
	self shouldThrowError: refactoring.
	^ refactoring
]

{ #category : #private }
GtBaseRefactroingExamples >> shouldThrowError: refactoring [
	[ refactoring primitiveExecute ] on: RBRefactoringError do: [ :ex | ^ nil ].
	self error: 'Refactoring did not throw an error'
]
