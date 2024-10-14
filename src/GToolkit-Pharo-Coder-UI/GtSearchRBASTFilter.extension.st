Extension { #name : #GtSearchRBASTFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchRBASTFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder)
		ifNotNil: [ :aFilterModel | aFilterModel text: self source ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchRBASTFilter class >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self sourceExpression: value ];
		named: 'AST';
		order: 100
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchRBASTFilter class >> globalFilterDescriptor2 [
	^ GtFilterTextModel new
		creator: [ :value | self sourceExpression: value ];
		named: 'AST';
		order: 100
]
