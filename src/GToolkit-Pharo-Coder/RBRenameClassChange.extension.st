Extension { #name : #RBRenameClassChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBRenameClassChange >> gtDiffChange [
	| aClass aDefinition oldSource newSource |
	
	aClass := self changeClass.
	aDefinition := GtBehaviorDefinition targetDefinitionForBehavior: aClass.
	
	oldSource := aDefinition asDefinitionString.
	
	aDefinition name: newName.
	newSource := aDefinition asDefinitionString.

	^ GtDiffBuilder
		computeDifferencesFrom: oldSource
		to: newSource
		using: GtSmaCCDiffSplitter forPharo
]
