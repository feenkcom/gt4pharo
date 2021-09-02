Extension { #name : 'GtPharoMethodsDefinition' }

{ #category : '*GToolkit-Pharo-Extensions' }
GtPharoMethodsDefinition >> gtMethodsFor: aView [
	<gtView>

	self isEmpty ifTrue: [ ^ aView empty ].

	^ aView columnedList
		title: 'Methods';
		priority: 1;
		items: [ definitions ];
		column: 'Selector' text: [ :eachMethod | eachMethod selector ];
		column: 'Protocol' text: [ :eachMethod | eachMethod protocol ]
]
