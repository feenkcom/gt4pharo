Extension { #name : #GtSearchRBPatternFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchRBPatternFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder)
		ifNotNil: [ :aFilterModel | aFilterModel text: self pattern ]
]

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
