Extension { #name : #RBAddPoolVariableChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBAddPoolVariableChange >> gtDiffChange [
	| aClass aDefinition oldSource newSource |
	aClass := self changeClass.
	aDefinition := GtBehaviorDefinition targetDefinitionForBehavior: aClass.
	oldSource := aDefinition asDefinitionString.

	aDefinition pools addPoolNamed: variable asSymbol.
	newSource := aDefinition asDefinitionString.

	^ GtDiffBuilder
		computeDifferencesFrom: oldSource
		to: newSource
		using: GtSmaCCDiffSplitter forPharo
]
