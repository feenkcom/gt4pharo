Extension { #name : #GtSearchRBPatternFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchRBPatternFilter class >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self pattern: value ];
		named: 'RBPattern';
		order: 100
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchRBPatternFilter class >> globalFilterDescriptor2 [
	^ GtFilterTextModel new
		creator: [ :value | self pattern: value ];
		named: 'RBPattern';
		order: 100
]
