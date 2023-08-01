Extension { #name : #GtSearchMethodCategoryFilter }

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
