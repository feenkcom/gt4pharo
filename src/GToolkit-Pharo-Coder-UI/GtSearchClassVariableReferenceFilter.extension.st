Extension { #name : #GtSearchClassVariableReferenceFilter }

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
