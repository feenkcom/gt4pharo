Extension { #name : #RBRemoveInstanceVariableChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBRemoveInstanceVariableChange >> gtDiffChange [
	| aDefinition oldSource newSource |
	self changeClass
		ifNotNil: [ :aClass | 
			aDefinition := GtBehaviorDefinition targetDefinitionForBehavior: aClass.
			oldSource := aDefinition asDefinitionString.
			aDefinition slots removeSlotNamed: variable asSymbol.
			newSource := aDefinition asDefinitionString ]
		ifNil: [ oldSource := ''.
			newSource := className , ' removeInstVarNamed: ''' , variable , '''' ].

	^ GtDiffBuilder
		computeDifferencesFrom: oldSource
		to: newSource
		using: GtSmaCCDiffSplitter forPharo
]
