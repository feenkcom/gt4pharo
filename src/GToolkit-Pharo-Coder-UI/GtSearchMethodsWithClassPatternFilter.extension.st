Extension { #name : #GtSearchMethodsWithClassPatternFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithClassPatternFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder)
		ifNotNil: [ :aFilterModel | aFilterModel text: self pattern ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithClassPatternFilter class >> filterDescriptor2For: aMethodsCoder [
	aMethodsCoder isForClass 
		ifTrue: [ ^ nil ].

	^ self globalFilterDescriptor2
		completion: [ GtStringsCompletionStrategy new completions: [ aMethodsCoder classNames ] ]
]

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
GtSearchMethodsWithClassPatternFilter class >> filterName [
	^ 'Class'
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithClassPatternFilter class >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self pattern: value ];
		named: 'Class';
		order: 20;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPharoIndex current classNameTree ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithClassPatternFilter class >> globalFilterDescriptor2 [
	^ GtFilterTextModel new
		creator: [ :value | self pattern: value ];
		named: self filterName;
		order: 20;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPharoIndex current classNameTree ] ]
]
