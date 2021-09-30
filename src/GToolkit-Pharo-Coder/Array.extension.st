Extension { #name : #Array }

{ #category : #'*GToolkit-Pharo-Coder' }
Array >> gtReferences [
	^ GtSearchReferencesFilter literal: self
]
