Extension { #name : #GtSubstringFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSubstringFilter class >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self substring: value ];
		named: 'Substring';
		order: 90
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSubstringFilter class >> globalFilterDescriptor2 [
	^ GtFilterTextModel new
		creator: [ :value | self substring: value ];
		named: 'Substring';
		order: 90
]
