Extension { #name : #GtSearchRBPatternFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchRBPatternFilter class >> filterDescriptorFor: aMethodsCoder [
	^ self globalFilterDescriptor
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchRBPatternFilter class >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self pattern: value ];
		named: 'RBPattern';
		order: 100
]
