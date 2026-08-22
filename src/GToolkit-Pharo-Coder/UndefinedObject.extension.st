Extension { #name : #UndefinedObject }

{ #category : #'*GToolkit-Pharo-Coder' }
UndefinedObject >> createReferencesFilterStoreStringFor: aFilter on: aStream [
	aFilter storeReferencesFilterCreationCodeForLiteral: self on: aStream
]

{ #category : #'*GToolkit-Pharo-Coder' }
UndefinedObject >> gtReferences [
	^ GtSearchReferencesFilter literal: self
]
