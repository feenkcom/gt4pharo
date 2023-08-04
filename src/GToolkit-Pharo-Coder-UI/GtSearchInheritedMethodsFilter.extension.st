Extension { #name : #GtSearchInheritedMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchInheritedMethodsFilter classSide >> filterDescriptorFor: aMethodsCoder [
	aMethodsCoder isForClass ifFalse: [ ^ nil ].

	^ GtFilterDescriptor new
		creator: [ :string | 
			(self forClass: aMethodsCoder classOrMetaClass)
				withSuperclassesUpTo: (Smalltalk at: string asSymbol) ];
		named: 'Methods up to';
		order: 16;
		beNotDefault;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree
						withAll: (aMethodsCoder classOrMetaClass withAllSuperclasses collect: #name) ] ];
		emptyDefaultValue: 'Object'
]
