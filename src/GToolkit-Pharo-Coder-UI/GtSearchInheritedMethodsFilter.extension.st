Extension { #name : #GtSearchInheritedMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchInheritedMethodsFilter class >> filterDescriptorFor: aMethodsCoder [
	aMethodsCoder isForClass ifFalse: [ ^ nil ].

	^ GtFilterDescriptor new
		creator: [ :string | 
			(self forClass: aMethodsCoder classOrMetaClass)
				withSuperclassesUpTo: (Smalltalk at: string asSymbol) ];
		named: 'Methods up to';
		order: 16;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree
						withAll: (aMethodsCoder classOrMetaClass withAllSuperclasses collect: #name) ] ];
		emptyDefaultValue: aMethodsCoder classOrMetaClass name;
		beNotDefault
]
