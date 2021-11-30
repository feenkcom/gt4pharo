Extension { #name : #GtSearchClassMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchClassMethodsFilter class >> filterDescriptorFor: aMethodsCoder [
	^ GtFilterDescriptor new
		creator: [ :value | self new ];
		named: 'Class Methods';
		order: 17;
		valueNotRequired;
		yourself
]
