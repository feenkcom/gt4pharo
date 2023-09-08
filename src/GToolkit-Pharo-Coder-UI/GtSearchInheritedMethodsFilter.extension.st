Extension { #name : #GtSearchInheritedMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchInheritedMethodsFilter class >> filterDescriptorFor: aMethodsCoder [
	| currentClass |
	aMethodsCoder isForClass ifFalse: [ ^ nil ].
	currentClass := aMethodsCoder classOrMetaClass.
	^ GtFilterDescriptor new
		creator: [ :string | 
			(self forClass: currentClass)
				withSuperclassesUpTo: (Smalltalk at: string asSymbol ifAbsent: [ currentClass ]) ];
		named: 'Methods up to';
		order: 16;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: (currentClass withAllSuperclasses collect: #name) ] ];
		emptyDefaultValue: currentClass name;
		beNotDefault
]
