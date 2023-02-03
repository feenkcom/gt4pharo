Extension { #name : #RBAddClassVariableChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBAddClassVariableChange >> gtDiffChange [
	| aClass aDefinition oldSource newSource |
	aClass := self changeClass.
	aDefinition := GtBehaviorDefinition targetDefinitionForBehavior: aClass.
	oldSource := aDefinition asDefinitionString.

	aDefinition classVariables addClassVariableNamed: variable asSymbol.
	newSource := aDefinition asDefinitionString.

	^ GtDiffBuilder
		computeDifferencesFrom: oldSource
		to: newSource
		using: GtSmaCCDiffSplitter forPharo
]
