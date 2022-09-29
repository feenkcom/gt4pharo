Extension { #name : #GtSearchMethodsWithClassPatternFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithClassPatternFilter class >> filterDescriptorFor: aMethodsCoder [
	aMethodsCoder isForClass
		ifTrue: [ ^ nil ].

	^ GtFilterDescriptor new
		creator: [ :value | self pattern: value ];
		named: 'Class';
		order: 20;
		completion: [ GtStringsCompletionStrategy new completions: [ aMethodsCoder classNames ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithClassPatternFilter class >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self pattern: value ];
		named: 'Class';
		order: 20;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPharoIndex current globalCache ] ]
]
