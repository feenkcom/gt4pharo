Extension { #name : #RBAddInstanceVariableChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBAddInstanceVariableChange >> gtDiffChange [
	| oldSource newSource aDefinition |
	self changeClass
		ifNil: [ oldSource := ''.
			newSource := className , ' addInstVarNamed: ''' , variable , '''' ]
		ifNotNil: [ :aClass | 
			aDefinition := GtBehaviorDefinition targetDefinitionForBehavior: aClass.
			oldSource := aDefinition asDefinitionString.

			aDefinition slots addSlotNamed: variable asSymbol.
			newSource := aDefinition asDefinitionString ].

	^ GtDiffBuilder
		computeDifferencesFrom: oldSource
		to: newSource
		using: GtSmaCCDiffSplitter forPharo
]
