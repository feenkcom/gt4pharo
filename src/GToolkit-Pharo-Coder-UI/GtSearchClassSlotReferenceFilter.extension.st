Extension { #name : #GtSearchClassSlotReferenceFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchClassSlotReferenceFilter class >> filterDescriptor2For: aMethodsCoder [
	aMethodsCoder isForClass ifFalse: [ ^ nil ].

	^ GtFilterShortListModel new
		creator: [ :anItem | 
			anItem
				ifSome: [ :aName | 
					self
						forClassAndHierarchy: aMethodsCoder classOrMetaClass classSide
						andVariable: aName ]
				ifNone: [ self
						forClassAndHierarchy: aMethodsCoder classOrMetaClass classSide
						andVariable: '' ] ];
		named: 'Class slots';
		order: 26;
		items: [ GtFilterModelAllItem methodsLabel
				withAll: (aMethodsCoder classOrMetaClass classSide allInstVarNames
						sort: [ :a :b | a < b ]) ];
		selectedItem: GtFilterModelAllItem methodsLabel;
		displayAllItems
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchClassSlotReferenceFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder)
		ifNotNil: [ :aFilterModel | 
			aFilterModel
				selectedItem: (self variableName ifEmpty: [ GtFilterModelAllItem methodsLabel ]) ]
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
