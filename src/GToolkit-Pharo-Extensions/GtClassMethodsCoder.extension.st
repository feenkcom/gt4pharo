Extension { #name : #GtClassMethodsCoder }

{ #category : #'*GToolkit-Pharo-Extensions' }
GtClassMethodsCoder >> gtSpotterMethodsFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 10;
		title: 'Methods';
		items: [ self coders ];
		itemName: [ :method | method selector ];
		previewElement: [ :coder | coder previewElement ];
		filterBySubstring
]
