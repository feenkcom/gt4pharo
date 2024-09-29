Extension { #name : #GtSearchClassSlotReferenceFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchClassSlotReferenceFilter class >> filterDescriptor2For: aMethodsCoder [
	aMethodsCoder isForClass
		ifFalse: [ ^ nil ].

	^ GtFilterShortListModel new
		creator: [ :anItem | 
			anItem ifSome: [ :aName |
				self
					forClassAndHierarchy: aMethodsCoder classOrMetaClass classSide
					andVariable: aName ] ];
		named: 'Class slots';
		order: 27;
		items: aMethodsCoder classOrMetaClass classSide allInstVarNames;
		selectFirstItem
]

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
