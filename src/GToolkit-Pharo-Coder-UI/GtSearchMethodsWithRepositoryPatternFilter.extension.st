Extension { #name : #GtSearchMethodsWithRepositoryPatternFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithRepositoryPatternFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder)
		ifNotNil: [ :aFilterModel | aFilterModel text: self pattern ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithRepositoryPatternFilter classSide >> filterDescriptor2For: aMethodsCoder [
	^ self globalFilterDescriptor2
		completion: [ GtStringsCompletionStrategy new completions: [ aMethodsCoder packageNames ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithRepositoryPatternFilter classSide >> filterDescriptorFor: aMethodsCoder [
	^ GtFilterDescriptor new
		creator: [ :value | self pattern: value ];
		named: 'Repository';
		order: 30;
		completion: [ GtStringsCompletionStrategy new completions: [ aMethodsCoder packageNames ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithRepositoryPatternFilter classSide >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self pattern: value ];
		named: 'Repository';
		order: 30;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: RPackageOrganizer default packageNames ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithRepositoryPatternFilter classSide >> globalFilterDescriptor2 [
	^ GtFilterTextModel new
		creator: [ :value | self pattern: value ];
		named: 'Repository';
		order: 30;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: RPackageOrganizer default packageNames ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithRepositoryPatternFilter classSide >> packageFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self pattern: value ];
		named: 'Repository';
		order: 30;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: RPackageOrganizer default packageNames ] ]
]
