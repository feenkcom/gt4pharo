Extension { #name : 'GtTraitsDefinition' }

{ #category : '*GToolkit-Pharo-Extensions' }
GtTraitsDefinition >> gtTraitsFor: aView [
	<gtView>
	
	definitions
		ifEmpty: [ ^ aView empty ].
	
	^ aView list
		title: 'Traits';
		priority: 1;
		items: [ definitions ]
]
