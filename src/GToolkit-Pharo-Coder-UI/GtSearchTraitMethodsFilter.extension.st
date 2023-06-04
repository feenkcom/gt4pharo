Extension { #name : #GtSearchTraitMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchTraitMethodsFilter class >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self new ];
		named: 'Trait Methods';
		order: 19;
		valueNotRequired;
		beNotDefault;
		yourself
]
