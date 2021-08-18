Extension { #name : 'UndefinedObject' }

{ #category : '*GToolkit-Pharo-Coder' }
UndefinedObject >> gtReferences [
	^ GtSearchReferencesFilter literal: self
]
