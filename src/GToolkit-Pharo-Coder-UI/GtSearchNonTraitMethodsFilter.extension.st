Extension { #name : #GtSearchNonTraitMethodsFilter }

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
