Extension { #name : #GtSearchImplementorPatternFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchImplementorPatternFilter class >> filterDescriptor2For: aMethodsCoder [
	^ self globalFilterDescriptor2
		completion: [ GtStringsCompletionStrategy new 
			completions: [ aMethodsCoder selectorNames ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchImplementorPatternFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder) 
		text: self pattern
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchImplementorPatternFilter class >> filterDescriptorFor: aMethodsCoder [
	^ GtFilterDescriptor new
		creator: [ :value | self pattern: value ];
		named: 'Implementor';
		order: 10;
		completion: [ GtStringsCompletionStrategy new completions: [ aMethodsCoder selectorNames ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchImplementorPatternFilter class >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self pattern: value ];
		named: 'Implementor';
		order: 10;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPharoIndex current selectorCache ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchImplementorPatternFilter class >> globalFilterDescriptor2 [
	^ GtFilterTextModel new
		creator: [ :value | self pattern: value ];
		named: 'Implementor';
		order: 10;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPharoIndex current selectorCache ] ]
]
