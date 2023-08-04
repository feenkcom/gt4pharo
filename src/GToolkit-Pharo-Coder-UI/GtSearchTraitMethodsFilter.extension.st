Extension { #name : #GtSearchTraitMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchTraitMethodsFilter class >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self new ];
		named: 'Trait methods';
		order: 19;
		valueNotRequired;
		beNotDefault;
		yourself
]
