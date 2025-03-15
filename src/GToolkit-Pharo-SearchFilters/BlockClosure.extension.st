Extension { #name : #BlockClosure }

{ #category : #'*GToolkit-Pharo-SearchFilters' }
BlockClosure >> gtMethodMatches [
	^ GtSearchMethodConditionsFilter condition: self
]
