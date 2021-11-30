Extension { #name : #GtSubstringFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSubstringFilter class >> filterDescriptorFor: aMethodsCoder [
	^ GtFilterDescriptor new
		creator: [ :value | self substring: value ];
		named: 'Substring';
		order: 90
]
