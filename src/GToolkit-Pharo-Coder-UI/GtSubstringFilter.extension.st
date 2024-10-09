Extension { #name : #GtSubstringFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSubstringFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder)
		ifNotNil: [ :aFilterModel | aFilterModel text: self substring ]
]

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
