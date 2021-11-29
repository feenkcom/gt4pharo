Extension { #name : #GtSearchRBPatternFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchRBPatternFilter class >> filterDescriptorFor: aMethodsCoder [
	^ GtFilterDescriptor new
		creator: [ :value | self pattern: value ];
		named: 'RBPattern';
		order: 100
]
