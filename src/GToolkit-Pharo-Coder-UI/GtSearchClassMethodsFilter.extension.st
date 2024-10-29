Extension { #name : #GtSearchClassMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchClassMethodsFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder) ifNotNil: [ :aFilterModel | 
		aFilterModel selectedItem: GtFilterModelClassSideItem default ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchClassMethodsFilter class >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self new ];
		named: 'Class methods';
		order: 17;
		valueNotRequired;
		beNotDefault;
		yourself
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchClassMethodsFilter class >> globalFilterDescriptor2 [
	^ GtFilterShortListModel new
		creator: [ :anItem | anItem isInstanceSideMethod
			ifTrue: [ GtSearchInstanceMethodsFilter new ] 
			ifFalse: [ self new ] ];
		named: 'Inst./Class methods';
		suffixLabel: 'methods';
		order: 17;
		items: { GtFilterModelInstanceSideItem default. GtFilterModelClassSideItem default };
		selectFirstItem
]
