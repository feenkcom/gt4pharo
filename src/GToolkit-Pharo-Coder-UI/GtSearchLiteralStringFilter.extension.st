Extension { #name : #GtSearchLiteralStringFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchLiteralStringFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder) 
		text: self substring
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchLiteralStringFilter class >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self substring: value ];
		named: 'Substring literal';
		order: 91
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchLiteralStringFilter class >> globalFilterDescriptor2 [
	^ GtFilterTextModel new
		creator: [ :value | self substring: value ];
		named: 'Substring literal';
		order: 91
]
