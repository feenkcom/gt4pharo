Extension { #name : #GtPharoTestCaseStateFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoTestCaseStateFilter class >> filterDescriptor2For: aMethodsCoder [
	aMethodsCoder testSuite ifNil: [ ^ nil ].
	
	^ GtFilterShortListModel new
		creator: [ :anItem | 
			anItem ifSome: [ :aName |
				self new
					resultStateString: aName;
					pharoTestSuite: aMethodsCoder testSuite ] ];
		named: 'Tests';
		order: 13;
		items: GtPharoMethodTestCaseState allLabels;
		selectedItem: self defaultState label
]

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
