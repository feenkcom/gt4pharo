Extension { #name : #LiteralVariable }

{ #category : #'*GToolkit-Pharo-Coder' }
LiteralVariable >> createReferencesFilterStoreStringFor: aFilter on: aStream [
	aFilter storeDefaultReferencesFilterCreationCodeOn: aStream
]

{ #category : #'*GToolkit-Pharo-Coder' }
LiteralVariable >> gtReferences [
	^ GtSearchReferencesFilter literal: self
]
