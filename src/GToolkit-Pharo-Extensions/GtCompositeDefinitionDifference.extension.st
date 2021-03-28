Extension { #name : #GtCompositeDefinitionDifference }

{ #category : #'*GToolkit-Pharo-Extensions' }
GtCompositeDefinitionDifference >> gtDifferencesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Differences';
		priority: 1;
		items: [ self differences ]
]
