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
