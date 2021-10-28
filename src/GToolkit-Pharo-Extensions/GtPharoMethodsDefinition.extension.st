Extension { #name : #GtPharoMethodsDefinition }

{ #category : #'*GToolkit-Pharo-Extensions' }
GtPharoMethodsDefinition >> gtMethodsCoderFor: aView [
	<gtView>

	self isEmpty ifTrue: [ ^ aView empty ].

	^ aView explicit
		title: 'Methods';
		priority: 1;
		stencil: [ 
			GtPharoMethodsCoder forItems: self definitions
		]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
GtPharoMethodsDefinition >> gtMethodsFor: aView [
	<gtView>

	self isEmpty ifTrue: [ ^ aView empty ].

	^ aView columnedList
		title: 'Selectors';
		priority: 2;
		items: [ definitions ];
		column: 'Selector' text: [ :eachMethod | eachMethod selector ];
		column: 'Protocol' text: [ :eachMethod | eachMethod protocol ]
]
