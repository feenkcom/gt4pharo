Extension { #name : 'RBRemovePoolVariableChange' }

{ #category : '*GToolkit-Pharo-Coder' }
RBRemovePoolVariableChange >> gtDiff [
	| aClass aDefinition oldSource newSource |
	
	aClass := self changeClass.
	aDefinition := GtBehaviorDefinition targetDefinitionForBehavior: aClass.
	oldSource := aDefinition asDefinitionString.
	
	aDefinition pools removePoolNamed: variable asSymbol.
	newSource := aDefinition asDefinitionString.

	^ ClassDiffBuilder
		from: oldSource
		to: newSource
		inClass: aClass
]
