Class {
	#name : #GtBaseRefactoringExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-BaseRefactorings-Examples'
}

{ #category : #'as yet unclassified' }
GtBaseRefactoringExamples >> failAddPool [
	<gtExample>
	| refactoring |
	refactoring := GtRBAddPoolVariableRefactoring variable: 'Foo' class: self class.
	^ self shouldThrowError: refactoring
]

{ #category : #'as yet unclassified' }
GtBaseRefactoringExamples >> failAddTrait [
	<gtExample>
	| refactoring |
	refactoring := GtRBAddTraitUsageRefactoring traitName: #Foo class: self class.
	^ self shouldThrowError: refactoring
]

{ #category : #'as yet unclassified' }
GtBaseRefactoringExamples >> failAddTraitUsage [
	<gtExample>
	| refactoring |
	refactoring := GtRBAddTraitUsageToClassByNameRefactoring
			traitName: #Object
			inClassNamed: self class name.
	^ self shouldThrowError: refactoring
]

{ #category : #'create accessors' }
GtBaseRefactoringExamples >> failCreateAccessorsOnMissingVariable [
	<gtExample>
	| refactoring |
	refactoring := RBCreateAccessorsForVariableRefactoring
			instanceVariable: 'foo'
			class: self class.
	^ self shouldThrowError: refactoring
]

{ #category : #'create accessors' }
GtBaseRefactoringExamples >> failCreateAccessorsWithBadInitialization [
	<gtExample>
	| refactoring |
	refactoring := RBCreateAccessorsWithLazyInitializationForVariableRefactoring
			variable: 'array'
			class: OrderedCollection
			classVariable: false
			defaultValue: '#( 43'.
	^ self shouldThrowError: refactoring
]

{ #category : #'as yet unclassified' }
GtBaseRefactoringExamples >> failMoveClassToPackage [
	<gtExample>
	| refactoring |
	refactoring := GtRBMoveClassToPackageRefactoring
			move: #UnknownClass
			to: self class package name.
	^ self shouldThrowError: refactoring
]

{ #category : #'as yet unclassified' }
GtBaseRefactoringExamples >> failPackageClass [
	<gtExample>
	| refactoring |
	refactoring := GtRBPackageClassRefactoring
			class: self class
			packageName: ''
			tagName: 'Foo'.
	^ self shouldThrowError: refactoring
]

{ #category : #'create accessors' }
GtBaseRefactoringExamples >> failRemovePoolVariable [
	<gtExample>
	| refactoring |
	refactoring := GtRBRemovePoolVariableRefactoring
			variable: #Foo
			class: self class.
	^ self shouldThrowError: refactoring
]

{ #category : #'as yet unclassified' }
GtBaseRefactoringExamples >> failRemoveTrait [
	<gtExample>
	| refactoring |
	refactoring := GtRBRemoveTraitUsageRefactoring
			traitName: #TSmaCCParseNodeVisitor
			class: self class.
	^ self shouldThrowError: refactoring
]

{ #category : #'remove class' }
GtBaseRefactoringExamples >> failRemoveUnknownClass [
	<gtExample>
	| refactoring |
	refactoring := RBRemoveClassRefactoring classNames: #(#AsdfFoo).
	^ self shouldThrowError: refactoring
]

{ #category : #'remove class variable' }
GtBaseRefactoringExamples >> failRemoveUnknownClassVariable [
	<gtExample>
	| refactoring |
	refactoring := RBRemoveClassVariableRefactoring
			variable: 'Foo'
			class: self class.
	^ self shouldThrowError: refactoring
]

{ #category : #'remove inst variable' }
GtBaseRefactoringExamples >> failRemoveUnknownInstanceVariable [
	<gtExample>
	| refactoring |
	refactoring := RBRemoveInstanceVariableRefactoring
			variable: 'foo'
			class: self class.
	^ self shouldThrowError: refactoring
]

{ #category : #'rename class variable' }
GtBaseRefactoringExamples >> failRenameClass [
	<gtExample>
	| refactoring |
	refactoring := RBRenameClassRefactoring rename: self class name to: #'Foo 1'.
	^ self shouldThrowError: refactoring
]

{ #category : #'rename class variable' }
GtBaseRefactoringExamples >> failRenameClassVariable [
	<gtExample>
	| refactoring |
	refactoring := RBRenameClassVariableRefactoring
			rename: 'Foo'
			to: 'Bar'
			in: self class.
	^ self shouldThrowError: refactoring
]

{ #category : #'rename class variable' }
GtBaseRefactoringExamples >> failRenameMethod [
	<gtExample>
	| refactoring |
	refactoring := RBRenameMethodRefactoring
			renameMethod: #at:put:
			in: Object
			to: #at:ifAbsent:
			permutation: #(1 2).
	^ self shouldThrowError: refactoring
]

{ #category : #'as yet unclassified' }
GtBaseRefactoringExamples >> failRenamePackage [
	<gtExample>
	| refactoring |
	refactoring := GtRBRenamePackageRefactoring
			from: self class package name , '123'
			to: self class package name.
	^ self shouldThrowError: refactoring
]

{ #category : #'as yet unclassified' }
GtBaseRefactoringExamples >> failRenamePackageTag [
	<gtExample>
	| refactoring |
	refactoring := GtRBRenamePackageTagRefactoring
			packageName: self class package name
			from: 'Examples1'
			to: 'Ex'.
	^ self shouldThrowError: refactoring
]

{ #category : #'create accessors' }
GtBaseRefactoringExamples >> failRenameProtocol [
	<gtExample>
	| refactoring |
	refactoring := GtRBRenameProtocolRefactoring
			renameProtocol: #unknown
			in: self class
			to: #asdf.
	^ self shouldThrowError: refactoring
]

{ #category : #private }
GtBaseRefactoringExamples >> shouldThrowError: refactoring [
	[ refactoring primitiveExecute ]
		on: RBRefactoringError
		do: [ :ex | ^ ex copy freeze ].
	self error: 'Refactoring did not throw an error'
]
