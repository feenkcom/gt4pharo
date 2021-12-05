Extension { #name : #GtSearchSubclassResponsibilityMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchSubclassResponsibilityMethodsFilter class >> filterDescriptorFor: aMethodsCoder [
	^ GtFilterDescriptor new
		creator: [ :value | self new ];
		named: 'Abstract Methods';
		order: 18;
		valueNotRequired;
		yourself
]
