Extension { #name : #GtSearchPragmasFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchPragmasFilter class >> filterDescriptor2For: aMethodsCoder [
	| somePragmaNames |
	^ GtFilterShortListModel new
		creator: [ :anItem |
			anItem 
				ifSome: [ :aName | self forPragma: aName ]
				ifNone: [ self class new ] ];
		named: 'Pragma';
		order: 11;
		items: (somePragmaNames := aMethodsCoder pragmaNames);
		selectFirstItem
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchPragmasFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder)
		ifNotNil: [ :aFilterModel | aFilterModel selectedItem: self symbol ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchPragmasFilter class >> filterDescriptorFor: aMethodsCoder [
	^ GtFilterDescriptor new
		creator: [ :value | self forPragma: value ];
		named: 'Pragma';
		order: 11;
		completion: [ GtStringsCompletionStrategy new completions: [ aMethodsCoder pragmaNames ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchPragmasFilter class >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self forPragma: value ];
		named: 'Pragma';
		order: 11;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: Pragma pragmaCache keys ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchPragmasFilter class >> globalFilterDescriptor2 [
	^ GtFilterTextModel new
		creator: [ :aString | self forPragma: aString ];
		named: 'Pragma';
		order: 11;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: Pragma pragmaCache keys ] ]
]
