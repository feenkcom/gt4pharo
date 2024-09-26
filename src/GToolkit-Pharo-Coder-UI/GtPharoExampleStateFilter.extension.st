Extension { #name : #GtPharoExampleStateFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoExampleStateFilter class >> filterDescriptor2For: aMethodsCoder [
	aMethodsCoder exampleSuite ifNil: [ ^ nil ].
	
	^ GtFilterShortListModel new
		creator: [ :anItem | 
			anItem ifSome: [ :aName |
				self new
					resultStateString: aName;
					pharoExampleSuite: aMethodsCoder exampleSuite ] ];
		named: 'Examples';
		order: 12;
		items: GtExampleState default allLabels;
		selectedItem: self defaultState label
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
