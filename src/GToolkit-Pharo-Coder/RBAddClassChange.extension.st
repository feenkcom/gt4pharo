Extension { #name : #RBAddClassChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBAddClassChange >> gtDiffChange [
	| aClass oldSource newSource namespace |
	aClass := self changeClass.

	oldSource := aClass
			ifNil: [ '' ]
			ifNotNil: [ namespace := GtRBNamespace new.
				(namespace classNamed: aClass name)
					gtRemoveSlotsFromTraits;
					gtDefinitionString ].
	newSource := self definition.

	^ GtDiffBuilder
		computeDifferencesFrom: oldSource
		to: newSource
		using: GtSmaCCDiffSplitter forPharo
]

{ #category : #'*GToolkit-Pharo-Coder' }
RBAddClassChange >> gtViewDefinitionFor: aView [
	<gtView>
	^ aView textEditor
		priority: 50;
		title: 'Definition';
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self definition asRopedText ]
]
