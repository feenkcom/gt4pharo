Extension { #name : #GtPharoExampleStateFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoExampleStateFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder)
		ifNotNil: [ :aFilterModel | aFilterModel selectedItem: self resultState ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoExampleStateFilter class >> filterDescriptor2For: aMethodsCoder [
	aMethodsCoder exampleSuite ifNil: [ ^ nil ].

	^ GtFilterShortListModel new
		creator: [ :anItem | 
			anItem
				ifSome: [ :aResultState | 
					self new
						resultState: aResultState;
						pharoExampleSuite: aMethodsCoder exampleSuite ]
				ifNone: [ 
					self new
						resultState: self defaultState;
						pharoExampleSuite: aMethodsCoder exampleSuite ] ];
		named: 'Examples';
		order: 12;
		items: GtExampleState default allStates;
		selectedItem: self defaultState
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoExampleStateFilter class >> filterDescriptorFor: aMethodsCoder [
	^ GtFilterDescriptor new
		creator: [ :value | 
			self new
				resultStateString: value;
				pharoExampleSuite: aMethodsCoder exampleSuite ];
		named: 'Examples';
		order: 12;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: GtExampleState default allLabels ] ];
		emptyDefaultValue: self defaultState label;
		beNotDefault
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoExampleStateFilter class >> globalFilterDescriptor [
	^ nil
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoExampleStateFilter class >> globalFilterDescriptor2 [
	^ nil
]
