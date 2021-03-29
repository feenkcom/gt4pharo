Extension { #name : #GtClassMethodsCoder }

{ #category : #'*GToolkit-Pharo-Extensions' }
GtClassMethodsCoder >> gtSpotterMethodsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 10;
		title: 'Methods';
		allCandidates: [ self coders ];
		itemName: [ :method | method selector ];
		previewElement: [ :coder | coder previewElement ];
		filter: GtFilterSubstring
]
