Extension { #name : #GtSearchInstanceSlotReferenceFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchInstanceSlotReferenceFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder)
		ifNotNil: [ :aFilterModel | 
			aFilterModel
				selectedItem: (self variableName ifEmpty: [ GtFilterModelAllItem methodsLabel ]) ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchInstanceSlotReferenceFilter class >> filterDescriptor2For: aMethodsCoder [
	aMethodsCoder isForClass ifFalse: [ ^ nil ].

	^ GtFilterShortListModel new
		creator: [ :anItem | 
			anItem
				ifSome: [ :aName | self forClassAndHierarchy: aMethodsCoder classOrMetaClass andVariable: aName ]
				ifNone: [ self forClassAndHierarchy: aMethodsCoder classOrMetaClass andVariable: '' ] ];
		named: 'Instance slots';
		order: 25;
		items: [ GtFilterModelAllItem methodsLabel withAll: (aMethodsCoder classOrMetaClass allInstVarNames sort: [ :a :b | a < b ]) ];
		selectedItem: GtFilterModelAllItem methodsLabel;
		displayAllItems
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
