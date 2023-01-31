Extension { #name : #RBRemoveInstanceVariableChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBRemoveInstanceVariableChange >> gtDiffChange [
	| aClass aDefinition oldSource newSource |
	aClass := self changeClass.
	aDefinition := GtBehaviorDefinition targetDefinitionForBehavior: aClass.
	oldSource := aDefinition asDefinitionString.

	aDefinition slots removeSlotNamed: variable asSymbol.
	newSource := aDefinition asDefinitionString.

	^ GtDiffBuilder
		computeDifferencesFrom: oldSource
		to: newSource
		using: GtSmaCCDiffSplitter forPharo
]
