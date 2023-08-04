Extension { #name : #GtSearchInstanceMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchInstanceMethodsFilter class >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self new ];
		named: 'Instance methods';
		order: 16;
		valueNotRequired;
		beNotDefault;
		yourself
]
