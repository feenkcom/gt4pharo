Extension { #name : #GtSearchLiteralStringFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchLiteralStringFilter class >> filterDescriptorFor: aMethodsCoder [
	^ GtFilterDescriptor new
		creator: [ :value | self substring: value ];
		named: 'Substring Literal';
		order: 91
]
