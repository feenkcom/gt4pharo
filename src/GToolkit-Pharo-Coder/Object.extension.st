Extension { #name : #Object }

{ #category : #'*GToolkit-Pharo-Coder' }
Object >> createReferencesFilterStoreStringFor: aFilter on: aStream [
	aFilter storeDefaultReferencesFilterCreationCodeOn: aStream
]
