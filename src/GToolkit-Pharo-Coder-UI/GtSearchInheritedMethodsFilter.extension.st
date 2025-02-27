Extension { #name : #GtSearchInheritedMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchInheritedMethodsFilter class >> filterDescriptor2For: aMethodsCoder [
	| aCurrentClass |
	aMethodsCoder isForClass ifFalse: [ ^ nil ].
	aCurrentClass := aMethodsCoder classOrMetaClass.
	^ GtFilterShortListModel new
		creator: [ :anItem | 
			anItem
				ifSome: [ :anUpToClass | (self forClass: aCurrentClass) withSuperclassesUpTo: anUpToClass ]
				ifNone: [ (self forClass: aCurrentClass) withSuperclassesUpTo: aCurrentClass ] ];
		items: [ aCurrentClass withAllSuperclasses ];
		selectedItem: aCurrentClass;
		displayAllItems;
		name: self filterName;
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

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchInheritedMethodsFilter class >> filterName [
	^ 'Methods up to'
]
