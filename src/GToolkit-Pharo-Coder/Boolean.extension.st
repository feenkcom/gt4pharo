Extension { #name : #Boolean }

{ #category : #'*GToolkit-Pharo-Coder' }
Boolean >> createReferencesFilterStoreStringFor: aFilter on: aStream [
	aFilter storeReferencesFilterCreationCodeForLiteral: self on: aStream
]

{ #category : #'*GToolkit-Pharo-Coder' }
Boolean >> gtReferences [
	^ GtSearchReferencesFilter literal: self
]
