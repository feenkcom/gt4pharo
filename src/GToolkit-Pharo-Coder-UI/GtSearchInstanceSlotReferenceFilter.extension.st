Extension { #name : #GtSearchInstanceSlotReferenceFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchInstanceSlotReferenceFilter class >> filterDescriptor2For: aMethodsCoder [
	aMethodsCoder isForClass
		ifFalse: [ ^ nil ].

	^ GtFilterShortListModel new
		creator: [ :anItem |
			anItem ifSome: [ :aName | 
				self
					forClassAndHierarchy: aMethodsCoder classOrMetaClass
					andVariable: aName ] ];
		named: 'Instance slots';
		order: 25;
		items: aMethodsCoder classOrMetaClass allInstVarNames;
		selectFirstItem
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchInstanceSlotReferenceFilter class >> filterDescriptorFor: aMethodsCoder [
	aMethodsCoder isForClass
		ifFalse: [ ^ nil ].

	^ GtFilterDescriptor new
		creator: [ :value | 
			self
				forClassAndSubclasses: aMethodsCoder classOrMetaClass
				andVariable: value ];
		named: 'Slots';
		order: 25;
		completion: [ GtStringsCompletionStrategy new completions: [ GtPrefixTree withAll: aMethodsCoder classOrMetaClass allInstVarNames ] ]
]
