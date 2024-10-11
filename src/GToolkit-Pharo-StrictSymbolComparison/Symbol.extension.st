Extension { #name : #Symbol }

{ #category : #'*GToolkit-Pharo-StrictSymbolComparison' }
Symbol >> sameContentAs: aString [
	"Compare the receiver and aString."
	self == aString ifTrue: [^ true].
	self class == aString class ifTrue: [^ false].
	"Use String comparison otherwise"
	^ super sameContentAs: aString
]

{ #category : #'*GToolkit-Pharo-StrictSymbolComparison' }
Symbol class >> strictComparison [

	^ GtStrictSymbolComparisonFlag useStrictComparison
]
