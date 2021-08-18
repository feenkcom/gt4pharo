Extension { #name : 'Symbol' }

{ #category : '*GToolkit-Pharo-Coder' }
Symbol >> gtImplementors [
	^ GtSearchImplementorsFilter selector: self
]

{ #category : '*GToolkit-Pharo-Coder' }
Symbol >> gtPragmas [
	^ GtSearchPragmasFilter forPragma: self
]

{ #category : '*GToolkit-Pharo-Coder' }
Symbol >> gtReferences [
	^ GtSearchReferencesFilter literal: self
]
