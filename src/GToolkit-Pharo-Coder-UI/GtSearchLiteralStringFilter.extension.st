Extension { #name : #GtSearchLiteralStringFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchLiteralStringFilter class >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self substring: value ];
		named: 'Substring literal';
		order: 91
]
