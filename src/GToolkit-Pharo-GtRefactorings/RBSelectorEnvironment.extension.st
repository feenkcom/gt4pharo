Extension { #name : #RBSelectorEnvironment }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBSelectorEnvironment >> gtSelectorsFor: aView [
	<gtView>

	^ aView list
		title: 'Selectors';
		priority: 10;
		items: [ Array streamContents: [ :stream | 
			classSelectors keysAndValuesDo: [ :cls :selectors | 
				selectors do: [ :selector | 
					stream nextPut: ((self class environment 
						at: cls) >> selector) methodReference ] ] ] ]
]
