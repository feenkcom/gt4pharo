Extension { #name : #RBRenameClassVariableChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBRenameClassVariableChange >> gtDiffChange [
	| aClass aDefinition oldSource newSource |
	
	aClass := self changeClass.
	aDefinition := GtBehaviorDefinition targetDefinitionForBehavior: aClass.
	oldSource := aDefinition asDefinitionString.
	
	aDefinition classVariables renameClassVariableNamed: oldName asSymbol to: newName asSymbol.
	newSource := aDefinition asDefinitionString.

	^ GtDiffBuilder
		computeDifferencesFrom: oldSource
		to: newSource
		using: GtSmaCCDiffSplitter forPharo
]
