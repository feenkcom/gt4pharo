Extension { #name : #GtSearchClassMethodsFilter }

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
