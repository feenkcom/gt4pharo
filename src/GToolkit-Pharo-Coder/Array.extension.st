Extension { #name : #Array }

{ #category : #'*GToolkit-Pharo-Coder' }
Array >> createReferencesFilterStoreStringFor: aFilter on: aStream [
	aFilter storeReferencesFilterCreationCodeForLiteral: self on: aStream
]

{ #category : #'*GToolkit-Pharo-Coder' }
Array >> gtReferences [
	^ GtSearchReferencesFilter literal: self
]
