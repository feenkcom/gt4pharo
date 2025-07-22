Extension { #name : #GtSearchMethodsWithPackagePatternFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithPackagePatternFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder)
		ifNotNil: [ :aFilterModel | aFilterModel text: self pattern ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithPackagePatternFilter class >> filterDescriptor2For: aMethodsCoder [
	^ self globalFilterDescriptor2
		completion: [ GtStringsCompletionStrategy new completions: [ aMethodsCoder packageNames ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithPackagePatternFilter class >> filterDescriptorFor: aMethodsCoder [
	^ GtFilterDescriptor new
		creator: [ :value | self pattern: value ];
		named: 'Package';
		order: 30;
		completion: [ GtStringsCompletionStrategy new completions: [ aMethodsCoder packageNames ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithPackagePatternFilter class >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self pattern: value ];
		named: 'Package';
		order: 30;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: self packageOrganizer packageNames ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithPackagePatternFilter class >> globalFilterDescriptor2 [
	^ GtFilterTextModel new
		creator: [ :value | self pattern: value ];
		named: 'Package';
		order: 30;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: self packageOrganizer packageNames ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithPackagePatternFilter class >> packageFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self pattern: value ];
		named: 'Package';
		order: 30;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: self packageOrganizer packageNames ] ]
]
