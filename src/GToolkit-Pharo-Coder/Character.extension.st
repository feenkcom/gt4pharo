Extension { #name : #Character }

{ #category : #'*GToolkit-Pharo-Coder' }
Character >> gtReferences [
	^ GtSearchReferencesFilter literal: self
]
