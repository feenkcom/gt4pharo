Extension { #name : #RBAddClassChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBAddClassChange >> gtDiffChange [
	| aClass oldSource newSource |
	aClass := self changeClass.

	oldSource := aClass
			ifNil: [ '' ]
			ifNotNil: [ (RBClass existingNamed: aClass name)
					model: RBNamespace new;
					gtRemoveSlotsFromTraits;
					gtDefinitionString ].
	newSource := self definition.

	^ GtDiffBuilder
		computeDifferencesFrom: oldSource
		to: newSource
		using: GtSmaCCDiffSplitter forPharo
]
