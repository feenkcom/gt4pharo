Extension { #name : #GtSearchInstanceSlotReferenceFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchInstanceSlotReferenceFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder)
		ifNotNil: [ :aFilterModel | 
			aFilterModel
				selectedItem: (self variableName ifEmpty: [ GtFilterModelAllItem methodsLabel ]);
				parameterAt: 1 do: [ :aParameter | 
					self includeReaders & self includeWriters not
						ifFalse: [ aParameter selectItemAt: 2 ].
					self includeReaders not & self includeWriters 
						ifFalse: [ aParameter selectItemAt: 3 ].
				] ]
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
		displayAllItems;
		beDefault;
		parameter: (GtFilterShortListModelParameter new
			updater: [ :aFilter :anItem |
				anItem
					ifSome: [ :aValue |
						anItem onCreateFilter: aFilter ]
					ifNone: [  ] ];
			items: [ { 
				GtFilterModelPluggableItem new
					label: 'readers and writers';
					filterUpdater: [ :aFilter | 
						aFilter includeReaders: true.
						aFilter includeWriters: true ].
				GtFilterModelPluggableItem new
					label: 'readers only';
					filterUpdater: [ :aFilter | 
						aFilter includeReaders: true.
						aFilter includeWriters: false ].
				GtFilterModelPluggableItem new
					label: 'writers only';
					filterUpdater: [ :aFilter | 
						aFilter includeReaders: false.
						aFilter includeWriters: true ] } ];
			selectFirstItem;
			displayAllItems)
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
