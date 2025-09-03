Extension { #name : #GtSearchMethodCategoryFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodCategoryFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder)
		ifNotNil: [ :aFilterModel | 
			category ifNotNil: [ :aCategory |
				(Protocol gtAllProtocolDefaultName = aCategory) ifFalse: [
					aFilterModel selectedItem: aCategory ] ].
			aFilterModel ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodCategoryFilter class >> filterDescriptor2For: aMethodsCoder [
	^ GtFilterShortListModel new
		creator: [ :anItem | anItem 
			ifSome: [ :aName | self forCategory: aName ]
			ifNone: [ self new ] ];
		named: self filterName;
		order: 15;
		displayAllItems;
		items: (GtPharoStreamingMethodsCoderPossibleCategoriesBuilder new methodsCoder: aMethodsCoder);
		selectFirstItem
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodCategoryFilter class >> filterDescriptorFor: aMethodsCoder [
	^ GtFilterDescriptor new
		creator: [ :value | self forCategory: value ];
		named: 'Category';
		order: 15;
		beNotDefault;
		completion: [ GtStringsCompletionStrategy new completions: [ aMethodsCoder categories ] ];
		emptyDefaultValue: 'All'
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodCategoryFilter class >> filterName [
	^ 'Category'
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodCategoryFilter class >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self forCategory: value ];
		named: 'Category';
		order: 15;
		beNotDefault;
		emptyDefaultValue: 'All'
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodCategoryFilter class >> globalFilterDescriptor2 [
	^ GtFilterTextModel new
		creator: [ :value | self forCategory: value ];
		named: self filterName;
		order: 15;
		text: GtAllProtocol defaultName
]
