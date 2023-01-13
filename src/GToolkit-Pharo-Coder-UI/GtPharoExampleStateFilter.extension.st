Extension { #name : #GtPharoExampleStateFilter }

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
