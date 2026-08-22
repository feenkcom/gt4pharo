Extension { #name : #Character }

{ #category : #'*GToolkit-Pharo-Coder' }
Character >> createReferencesFilterStoreStringFor: aFilter on: aStream [
	aFilter storeReferencesFilterCreationCodeForLiteral: self on: aStream
]

{ #category : #'*GToolkit-Pharo-Coder' }
Character >> gtReferences [
	^ GtSearchReferencesFilter literal: self
]
