Extension { #name : #GtSearchPragmasFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchPragmasFilter class >> filterDescriptor2For: aMethodsCoder [
	^ GtFilterShortListModel new
		creator: [ :anItem |
			anItem ifSome: [ :aName | self forPragma: aName ] ];
		named: 'Pragma';
		order: 11;
		items: aMethodsCoder pragmaNames;
		selectFirstItem
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
