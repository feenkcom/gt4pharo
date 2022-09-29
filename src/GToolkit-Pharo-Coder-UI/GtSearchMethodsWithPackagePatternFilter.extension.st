Extension { #name : #GtSearchMethodsWithPackagePatternFilter }

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
				completions: [ GtPrefixTree withAll: RPackageOrganizer default packageNames ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsWithPackagePatternFilter class >> packageFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self pattern: value ];
		named: 'Package';
		order: 30;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: RPackageOrganizer default packageNames ] ]
]
