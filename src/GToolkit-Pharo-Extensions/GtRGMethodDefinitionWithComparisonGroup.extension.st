Extension { #name : #GtRGMethodDefinitionWithComparisonGroup }

{ #category : #'*GToolkit-Pharo-Extensions' }
GtRGMethodDefinitionWithComparisonGroup >> gtItemsFor: aView [
	<gtView>
	^(aView list)
		title: 'Items';
		priority: 45;
		withMultipleSelection;
		items: [ self items ];
		itemStencil: [GtPhlowLabelWithIcon new];
		itemDataBinder: [:anElement :aMethod |
			anElement updateForMethod: aMethod ];
		send: [:oneOrMoreMethods :selectionIndexes |
			selectionIndexes size = 1
				ifTrue: [ oneOrMoreMethods ]
				ifFalse: [
					(GtRGMethodDefinitionWithComparisonGroup 
						withAll: oneOrMoreMethods)
							highlighter: self highlighter ] ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
GtRGMethodDefinitionWithComparisonGroup >> gtViewComparisonFor: aView [
	<gtView>
	
	^(aView forward)
		title: 'Comparison';
		priority: 3;
		object: [
			| change styler compare |
			change := GtDiffBuilder
				computeDifferencesFrom: self penultimateMethod sourceCode
				to: self lastMethod sourceCode
				using: GtSmaCCDiffSplitter forPharo.
			styler := GtCodeDiffRBTextStyler new.
			compare := ((GtDiffElementWithLabelStencil new)
				fromLabelText: self penultimateMethod name;
				toLabelText: self lastMethod name;
				change: change;
				styler: styler) create ];
		view: #gtLiveFor:
]

{ #category : #'*GToolkit-Pharo-Extensions' }
GtRGMethodDefinitionWithComparisonGroup >> gtViewMethodsFor: aView [
	<gtView>

	^ aView forward
		title: 'Methods';
		priority: 20;
		object: [
			GtSearchFixedMethodsFilter new 
				withDefinedMethodsFrom: items;
				highlighter: self highlighter;
				label: 'Methods'];
		view: #gtItemsFor: 
]
