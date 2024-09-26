Extension { #name : #GtSearchInheritedMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchInheritedMethodsFilter class >> filterDescriptor2For: aMethodsCoder [
	| currentClass |
	aMethodsCoder isForClass ifFalse: [ ^ nil ].
	currentClass := aMethodsCoder classOrMetaClass.
	^ GtFilterShortListModel new
		creator: [ :anItem | 
			| upToClass |
			upToClass := Smalltalk at: anItem itemSymbol ifAbsent: [ currentClass ].
			(currentClass withAllSuperclasses includes: upToClass)
				ifFalse: [ upToClass := currentClass ].
			(self forClass: currentClass) withSuperclassesUpTo: upToClass ];
		items: currentClass withAllSuperclasses;
		selectedItem: currentClass;
		label: 'Methods up to';
		order: 16
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchInheritedMethodsFilter class >> filterDescriptorFor: aMethodsCoder [
	| currentClass |
	aMethodsCoder isForClass ifFalse: [ ^ nil ].
	currentClass := aMethodsCoder classOrMetaClass.
	^ GtFilterDescriptor new
		creator: [ :string | 
			| upToClass |
			upToClass := Smalltalk at: string asSymbol ifAbsent: [ currentClass ].
			(currentClass withAllSuperclasses includes: upToClass)
				ifFalse: [ upToClass := currentClass ].
			(self forClass: currentClass) withSuperclassesUpTo: upToClass ];
		named: 'Methods up to';
		order: 16;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: (currentClass withAllSuperclasses collect: #name) ] ];
		emptyDefaultValue: currentClass name;
		beNotDefault
]
