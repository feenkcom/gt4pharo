Extension { #name : 'GtSearchMethodsWithClassPatternFilter' }

{ #category : '*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithClassPatternFilter class >> filterDescriptorFor: aMethodsCoder [
	aMethodsCoder isForClass
		ifTrue: [ ^ nil ].
	^ GtFilterDescriptor
		creator: [ :value | self pattern: value ]
		named: 'Class'
		order: 20
		completion:
			(GtStringsCompletionStrategy new completions: aMethodsCoder classNames)
]
