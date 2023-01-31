Extension { #name : #RBRenameInstanceVariableChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBRenameInstanceVariableChange >> gtDiffChange [
	| aClass aDefinition oldSource newSource |
	
	aClass := self changeClass.
	aDefinition := GtBehaviorDefinition targetDefinitionForBehavior: aClass.
	oldSource := aDefinition asDefinitionString.
	
	aDefinition slots renameSlotNamed: oldName asSymbol to: newName asSymbol.
	newSource := aDefinition asDefinitionString.

	^ GtDiffBuilder
		computeDifferencesFrom: oldSource
		to: newSource
		using: GtSmaCCDiffSplitter forPharo
]
