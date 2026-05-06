Class {
	#name : #GtConvertEqualsToSameContentAsRefactoringExample,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Examples'
}

{ #category : #examples }
GtConvertEqualsToSameContentAsRefactoringExample >> convertEquals [
	<gtExample>
	| refactoring source node |
	source := self class sourceCodeAt: #sample:and:.
	node := (((GtPharoParser parse: source) // GtPharoBinaryMessageNode)
			@ #selectorPart <- '=') anyOne.
	refactoring := GtConvertEqualsToSameContentAsRefactoring
			model: GtRBNamespace new
			convert: node
			inMethod: #sample:and:
			forClass: self class.
	refactoring primitiveExecute.
	self
		assert: ((refactoring model classFor: self class) sourceCodeFor: #sample:and:)
		equals: 'sample: a and: b
	(a sameContentAs: b) ifTrue: [ ^ 0 ].
	^ a < b ifTrue: [ -1 ] ifFalse: [ 1 ]'.
	^ refactoring model
]

{ #category : #examples }
GtConvertEqualsToSameContentAsRefactoringExample >> failMessage [
	<gtExample>
	| refactoring source node |
	source := self class sourceCodeAt: #sample:and:.
	node := (((GtPharoParser parse: source) // GtPharoBinaryMessageNode)
			@ #selectorPart <- '<') anyOne.
	refactoring := GtConvertEqualsToSameContentAsRefactoring
			model: GtRBNamespace new
			convert: node
			inMethod: #sample:and:
			forClass: self class.
	[ refactoring primitiveExecute ]
		on: RBRefactoringError
		do: [ :ex | ^ ex copy freeze ].
	self error: 'Refactoring did not throw an error'
]

{ #category : #examples }
GtConvertEqualsToSameContentAsRefactoringExample >> sample: a and: b [
	a = b ifTrue: [ ^ 0 ].
	^ a < b ifTrue: [ -1 ] ifFalse: [ 1 ]
]
