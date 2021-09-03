Extension { #name : 'GtTagsDefinition' }

{ #category : '*GToolkit-Pharo-Extensions' }
GtTagsDefinition >> gtTagsFor: aView [
	<gtView>
	
	self isEmpty
		ifTrue: [ ^ aView empty ].
	
	^ aView list
		title: 'Tags';
		priority: 1;
		items: [ definitions ]
]
