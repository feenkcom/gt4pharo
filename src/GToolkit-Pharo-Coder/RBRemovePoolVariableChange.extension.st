Extension { #name : #RBRemovePoolVariableChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBRemovePoolVariableChange >> gtDiffChange [
	| aClass aDefinition oldSource newSource |
	aClass := self changeClass.
	aDefinition := GtBehaviorDefinition targetDefinitionForBehavior: aClass.
	oldSource := aDefinition asDefinitionString.

	aDefinition pools removePoolNamed: variable asSymbol.
	newSource := aDefinition asDefinitionString.

	^ GtDiffBuilder
		computeDifferencesFrom: oldSource
		to: newSource
		using: GtSmaCCDiffSplitter forPharo
]
