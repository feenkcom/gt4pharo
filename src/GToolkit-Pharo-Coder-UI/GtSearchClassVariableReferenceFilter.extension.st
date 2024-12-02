Extension { #name : #GtSearchClassVariableReferenceFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchClassVariableReferenceFilter class >> filterDescriptor2For: aMethodsCoder [
	aMethodsCoder isForClass ifFalse: [ ^ nil ].
	^ GtFilterShortListModel new
		creator: [ :anItem | 
			anItem
				ifSome: [ :aName | self forClass: aMethodsCoder classOrMetaClass andVariable: aName ]
				ifNone: [ self forClass: aMethodsCoder classOrMetaClass andVariable: '' ] ];
		named: 'Class variable';
		order: 27;
		items: [ GtFilterModelAllItem methodsLabel
				withAll: (aMethodsCoder classOrMetaClass allClassVarNames sort: [ :a :b | a < b ]) ];
		selectedItem: GtFilterModelAllItem methodsLabel;
		displayAllItems
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchClassVariableReferenceFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder)
		ifNotNil: [ :aFilterModel | 
			aFilterModel
				selectedItem: (self variableName ifEmpty: [ GtFilterModelAllItem methodsLabel ]) ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchClassVariableReferenceFilter class >> filterDescriptorFor: aMethodsCoder [
	aMethodsCoder isForClass
		ifFalse: [ ^ nil ].
	^ GtFilterDescriptor new
		creator: [ :value | self forClass: aMethodsCoder classOrMetaClass andVariable: value ];
		named: 'Class variable';
		order: 26;
		completion: [
			(GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: aMethodsCoder classOrMetaClass allClassVarNames ]) ]
]
