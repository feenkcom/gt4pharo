Extension { #name : #Number }

{ #category : #'*GToolkit-Pharo-Coder' }
Number >> gtReferences [
	^ GtSearchReferencesFilter literal: self
]
