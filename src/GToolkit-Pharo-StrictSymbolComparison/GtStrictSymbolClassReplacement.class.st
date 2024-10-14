Class {
	#name : #GtStrictSymbolClassReplacement,
	#superclass : #Object,
	#instVars : [
		'methodStream',
		'originalClass',
		'replacementClass'
	],
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Refactoring'
}

{ #category : #accessing }
GtStrictSymbolClassReplacement >> methodStream [
	^ methodStream ifNil: [ originalClass gtReferences result ]
]

{ #category : #accessing }
GtStrictSymbolClassReplacement >> methodStream: anObject [
	methodStream := anObject
]

{ #category : #accessing }
GtStrictSymbolClassReplacement >> originalClass [
	^ originalClass
]

{ #category : #accessing }
GtStrictSymbolClassReplacement >> originalClass: anObject [
	originalClass := anObject
]

{ #category : #actions }
GtStrictSymbolClassReplacement >> refactorAll [

	(self methodStream forEach: [ :method |
		self refactorMethod: method ]) wait
]

{ #category : #private }
GtStrictSymbolClassReplacement >> refactorMethod: method [ 
	| originalAst methodAst |

	originalAst := method parseTree.
	methodAst := originalAst copy.
	methodAst allChildren do: [ :node |
		(node isMessage and:
		[ (#(#new #new: #withAll: #newFrom: #empty #newFromPairs:) includes: node selector) and:
		[ node receiver isVariable and:
		[ node receiver name = originalClass name ] ] ]) ifTrue:
			[ node receiver name: replacementClass name ] ].
	methodAst ~= originalAst ifTrue:
		[ method methodClass
			compile: methodAst newSource
			classified: '*StrictSymbol-Refactored' ].
]

{ #category : #accessing }
GtStrictSymbolClassReplacement >> replacementClass [
	^ replacementClass
]

{ #category : #accessing }
GtStrictSymbolClassReplacement >> replacementClass: anObject [
	replacementClass := anObject
]
