Class {
	#name : #GtConvertEqualsToSameContentAsRefactoring,
	#superclass : #RBMethodRefactoring,
	#instVars : [
		'selector',
		'newSource',
		'comparisonNode'
	],
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Refactoring'
}

{ #category : #'instance creation' }
GtConvertEqualsToSameContentAsRefactoring class >> model: model convert: node inMethod: aSelector forClass: aClassOrSelector [
	^ self new
		model: model;
		convert: node
			inMethod: aSelector
			forClass: aClassOrSelector;
		yourself
]

{ #category : #transforming }
GtConvertEqualsToSameContentAsRefactoring >> basicTransform [
	| startPosition rbComparisonNode methodAst |
	methodAst := RBParser parseMethod: comparisonNode methodNode source.
	startPosition := comparisonNode message startPosition.
	rbComparisonNode := methodAst allChildren
			detect: [ :node | node isMessage and: [ node keywordsIntervals first first = startPosition ] ].
	rbComparisonNode
		selector: GtStrictSymbolEqualityArgumentSignal sameContentSelector.

	newSource := methodAst newSource
]

{ #category : #initialization }
GtConvertEqualsToSameContentAsRefactoring >> convert: node inMethod: aSelector forClass: aClassOrSelector [
	comparisonNode := node.
	selector := aSelector.
	class := self classObjectFor: aClassOrSelector
]

{ #category : #accessing }
GtConvertEqualsToSameContentAsRefactoring >> gtDescription [
	^ 'Convert #= to ', GtStrictSymbolEqualityArgumentSignal sameContentSelector
]

{ #category : #accessing }
GtConvertEqualsToSameContentAsRefactoring >> newSource [
	^ newSource
]

{ #category : #accessing }
GtConvertEqualsToSameContentAsRefactoring >> preconditions [
	^ RBCondition withBlock:
		[ comparisonNode selector == #= ].
]

{ #category : #transforming }
GtConvertEqualsToSameContentAsRefactoring >> privateTranform [
	self basicTransform
]

{ #category : #transforming }
GtConvertEqualsToSameContentAsRefactoring >> transform [
	self basicTransform
]
