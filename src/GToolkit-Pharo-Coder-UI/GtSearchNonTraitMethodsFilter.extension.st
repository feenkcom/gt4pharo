Extension { #name : #GtSearchNonTraitMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchNonTraitMethodsFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder)
		selectedItem: GtFilterModelClassOriginItem default
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchNonTraitMethodsFilter class >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self new ];
		named: 'Non-trait methods';
		order: 20;
		valueNotRequired;
		beNotDefault;
		yourself
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchNonTraitMethodsFilter class >> globalFilterDescriptor2 [
	^ GtFilterShortListModel new
		creator: [ :anItem | anItem isTraitOrigin
			ifTrue: [ GtSearchTraitMethodsFilter new ]
			ifFalse: [ self new ] ];
		named: 'Non/Trait methods';
		suffixLabel: 'methods';
		order: 20;
		items: { GtFilterModelTraitOriginItem default. GtFilterModelClassOriginItem default };
		selectLastItem;
		yourself
]
