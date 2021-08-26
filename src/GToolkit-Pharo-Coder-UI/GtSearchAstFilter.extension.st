Extension { #name : 'GtSearchAstFilter' }

{ #category : '*GToolkit-Pharo-Coder-UI' }
GtSearchAstFilter class >> filterDescriptorFor: aMethodsCoder [
	^ GtFilterDescriptor
		creator: [ :value | self sourceExpression: value ]
		named: 'AST'
		order: 100
]
