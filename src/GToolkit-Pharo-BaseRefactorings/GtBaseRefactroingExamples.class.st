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

{ #category : #'remove class' }
GtBaseRefactroingExamples >> failRemoveUnknownClass [
	<gtExample>
	| refactoring |
	refactoring := RBRemoveClassRefactoring classNames: #(AsdfFoo).
	self shouldThrowError: refactoring.
	^ refactoring
]

{ #category : #'remove class variable' }
GtBaseRefactroingExamples >> failRemoveUnknownClassVariable [
	<gtExample>
	| refactoring |
	refactoring := RBRemoveClassVariableRefactoring variable: 'Foo' class: self class.
	self shouldThrowError: refactoring.
	^ refactoring
]

{ #category : #'remove inst variable' }
GtBaseRefactroingExamples >> failRemoveUnknownInstanceVariable [
	<gtExample>
	| refactoring |
	refactoring := RBRemoveInstanceVariableRefactoring
			variable: 'foo'
			class: self class.
	self shouldThrowError: refactoring.
	^ refactoring
]

{ #category : #'rename class variable' }
GtBaseRefactroingExamples >> failRenameClass [
	<gtExample>
	| refactoring |
	refactoring := RBRenameClassRefactoring rename: self class name to: #'Foo 1'.
	self shouldThrowError: refactoring.
	^ refactoring
]

{ #category : #'rename class variable' }
GtBaseRefactroingExamples >> failRenameClassVariable [
	<gtExample>
	| refactoring |
	refactoring := RBRenameClassVariableRefactoring rename: 'Foo' to: 'Bar' in: self class.
	self shouldThrowError: refactoring.
	^ refactoring
]

{ #category : #'rename class variable' }
GtBaseRefactroingExamples >> failRenameMethod [
	<gtExample>
	| refactoring |
	refactoring := RBRenameMethodRefactoring renameMethod: #at:put: in: Object to: #at:ifAbsent: permutation: #(1 2).
	self shouldThrowError: refactoring.
	^ refactoring
]

{ #category : #private }
GtBaseRefactroingExamples >> shouldThrowError: refactoring [
	[ refactoring primitiveExecute ] on: RBRefactoringError do: [ :ex | ^ nil ].
	self error: 'Refactoring did not throw an error'
]
