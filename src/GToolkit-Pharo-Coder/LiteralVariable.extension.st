Extension { #name : #LiteralVariable }

{ #category : #'*GToolkit-Pharo-Coder' }
LiteralVariable >> gtReferences [
	^ GtSearchReferencesFilter literal: self
]
