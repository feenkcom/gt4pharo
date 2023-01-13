Extension { #name : #GtPharoTestCaseStateFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoTestCaseStateFilter class >> filterDescriptorFor: aMethodsCoder [
	^ GtFilterDescriptor new
		creator: [ :value | 
			self new
				resultStateString: value;
				pharoTestSuite: aMethodsCoder testSuite ];
		named: 'Tests';
		order: 13;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: GtPharoMethodTestCaseState allLabels ] ];
		emptyDefaultValue: self defaultState label;
		beNotDefault
]
