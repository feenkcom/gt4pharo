Extension { #name : 'GtSearchClassSlotReferenceFilter' }

{ #category : '*GToolkit-Pharo-Coder-UI' }
GtSearchClassSlotReferenceFilter class >> filterDescriptorFor: aMethodsCoder [
	aMethodsCoder isForClass
		ifFalse: [ ^ nil ].
	^ GtFilterDescriptor
		creator:
			[ :value | self forClass: aMethodsCoder classOrMetaClass andVariable: value ]
		named: 'Class Slot'
		order: 25
		completion:
			(GtStringsCompletionStrategy new
				completions:
					(GtPrefixTree withAll: aMethodsCoder classOrMetaClass allClassVarNames))
]
