Extension { #name : #ByteArray }

{ #category : #'*GToolkit-Pharo-Coder' }
ByteArray >> gtReferences [
	^ GtSearchReferencesFilter literal: self
]
