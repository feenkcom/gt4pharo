Extension { #name : #GtSearchSubclassResponsibilityMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchSubclassResponsibilityMethodsFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder)
		ifNotNil: [ :aFilterModel | aFilterModel selectedItem: GtFilterModelAbstractMethodItem default ]
]

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
			ifFalse: [ GtSearchDefinedMethodsFilter new ] ];
		named: 'Non/Abstract methods';
		order: 18;
		items: { GtFilterModelAbstractMethodItem default. GtFilterModelDefinedMethodItem default };
		selectFirstItem
]
