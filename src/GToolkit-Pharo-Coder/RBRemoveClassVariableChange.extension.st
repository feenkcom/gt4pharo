Extension { #name : #RBRemoveClassVariableChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBRemoveClassVariableChange >> gtDiffChange [
	| aClass aDefinition oldSource newSource |
	aClass := self changeClass.
	aDefinition := GtBehaviorDefinition targetDefinitionForBehavior: aClass.
	oldSource := aDefinition asDefinitionString.

	aDefinition classVariables removeClassVariableNamed: variable asSymbol.
	newSource := aDefinition asDefinitionString.

	^ GtDiffBuilder
		computeDifferencesFrom: oldSource
		to: newSource
		using: GtSmaCCDiffSplitter forPharo
]
