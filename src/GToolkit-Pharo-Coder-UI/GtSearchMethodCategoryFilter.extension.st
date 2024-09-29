Extension { #name : #GtSearchMethodCategoryFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodCategoryFilter class >> filterDescriptor2For: aMethodsCoder [
	^ GtFilterShortListModel new
		creator: [ :anItem | anItem ifSome: [ :aName | self forCategory: aName ] ];
		named: 'Category';
		order: 15;
		items: aMethodsCoder categories;
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
		named: 'Category';
		order: 15;
		text: 'All'
]
