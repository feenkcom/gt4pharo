Extension { #name : #Boolean }

{ #category : #'*GToolkit-Pharo-Coder' }
Boolean >> gtReferences [
	^ GtSearchReferencesFilter literal: self
]
