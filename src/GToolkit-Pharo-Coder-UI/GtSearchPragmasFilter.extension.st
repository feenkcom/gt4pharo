Extension { #name : #GtSearchPragmasFilter }

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
