Extension { #name : #ByteArray }

{ #category : #'*GToolkit-Pharo-Coder' }
ByteArray >> createReferencesFilterStoreStringFor: aFilter on: aStream [
	aFilter storeReferencesFilterCreationCodeForLiteral: self on: aStream
]

{ #category : #'*GToolkit-Pharo-Coder' }
ByteArray >> gtReferences [
	^ GtSearchReferencesFilter literal: self
]
