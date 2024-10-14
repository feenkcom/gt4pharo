Extension { #name : #GtPharoTestCaseStateFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoTestCaseStateFilter class >> filterDescriptor2For: aMethodsCoder [
	aMethodsCoder testSuite ifNil: [ ^ nil ].

	^ GtFilterShortListModel new
		creator: [ :anItem | 
			anItem
				ifSome: [ :aResultState | 
					self new
						resultState: aResultState;
						pharoTestSuite: aMethodsCoder testSuite ]
				ifNone: [ 
					self new
						resultState: self defaultState;
						pharoTestSuite: aMethodsCoder testSuite ] ];
		named: 'Tests';
		order: 13;
		items: (GtFilterModelTestCaseResultStateItem
				fromCollection: GtPharoMethodTestCaseState allStates);
		selectedItem: (GtFilterModelTestCaseResultStateItem new resultState: self defaultState)
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoTestCaseStateFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder)
		ifNotNil: [ :aFilterModel | 
			aFilterModel
				selectedItem: (GtFilterModelTestCaseResultStateItem new resultState: self resultState) ]
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
