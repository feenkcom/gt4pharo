Extension { #name : #GtSearchSubclassResponsibilityMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchSubclassResponsibilityMethodsFilter class >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self new ];
		named: 'Abstract methods';
		order: 18;
		valueNotRequired;
		beNotDefault;
		yourself
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchSubclassResponsibilityMethodsFilter class >> globalFilterDescriptor2 [
	^ GtFilterShortListModel new
		creator: [ :anItem | anItem isSubclassResponsibilityMethod
			ifTrue: [ self new ]
			ifFalse: [ self new not ] ];
		named: 'Non/Abstract methods';
		order: 18;
		items: { GtFilterModelDefinedMethodItem new. GtFilterModelAbstractMethodItem new };
		selectFirstItem
]
