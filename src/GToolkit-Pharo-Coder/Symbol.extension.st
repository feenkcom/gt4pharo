Extension { #name : #Symbol }

{ #category : #'*GToolkit-Pharo-Coder' }
Symbol >> createReferencesFilterStoreStringFor: aFilter on: aStream [
	aFilter storeReferencesFilterCreationCodeForLiteral: self on: aStream
]

{ #category : #'*GToolkit-Pharo-Coder' }
Symbol >> gtImplementors [
	^ GtSearchImplementorsFilter selector: self
]

{ #category : #'*GToolkit-Pharo-Coder' }
Symbol >> gtReferences [
	^ GtSearchReferencesFilter literal: self
]
