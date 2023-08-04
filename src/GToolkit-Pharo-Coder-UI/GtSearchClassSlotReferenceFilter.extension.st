Extension { #name : #GtSearchClassSlotReferenceFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchClassSlotReferenceFilter class >> filterDescriptorFor: aMethodsCoder [
	aMethodsCoder isForClass
		ifFalse: [ ^ nil ].

	^ GtFilterDescriptor new
		creator: [ :value | 
			self
				forClassAndSubclasses: aMethodsCoder classOrMetaClass classSide
				andVariable: value ];
		named: 'Class slots';
		order: 27;
		completion: [ GtStringsCompletionStrategy new completions: [ GtPrefixTree withAll: aMethodsCoder classOrMetaClass classSide allInstVarNames ] ]
]
