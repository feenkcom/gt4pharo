Extension { #name : #GtSearchClassVariableReferenceFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchClassVariableReferenceFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder)
		ifNotNil: [ :aFilterModel | aFilterModel selectedItem: self variableName ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchClassVariableReferenceFilter class >> filterDescriptor2For: aMethodsCoder [
	aMethodsCoder isForClass ifFalse: [ ^ nil ].
	^ GtFilterShortListModel new
		creator: [ :anItem | 
			anItem
				ifSome: [ :aName | self forClass: aMethodsCoder classOrMetaClass andVariable: aName ]
				ifNone: [ self forClass: aMethodsCoder classOrMetaClass andVariable: '' ] ];
		named: 'Class variable';
		order: 26;
		items: aMethodsCoder classOrMetaClass allClassVarNames;
		selectFirstItem
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchClassVariableReferenceFilter class >> filterDescriptorFor: aMethodsCoder [
	aMethodsCoder isForClass
		ifFalse: [ ^ nil ].
	^ GtFilterDescriptor new
		creator: [ :value | self forClass: aMethodsCoder classOrMetaClass andVariable: value ];
		named: 'Class variable';
		order: 26;
		completion: [
			(GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: aMethodsCoder classOrMetaClass allClassVarNames ]) ]
]
