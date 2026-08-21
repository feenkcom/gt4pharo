Extension { #name : #Number }

{ #category : #'*GToolkit-Pharo-Coder' }
Number >> createReferencesFilterStoreStringFor: aFilter on: aStream [
	aFilter storeReferencesFilterCreationCodeForLiteral: self on: aStream
]

{ #category : #'*GToolkit-Pharo-Coder' }
Number >> gtLiteralValueMatch [
	^ GtSearchLiteralValueFilter forValue: self
]

{ #category : #'*GToolkit-Pharo-Coder' }
Number >> gtReferences [
	^ GtSearchReferencesFilter literal: self
]
