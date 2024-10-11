Extension { #name : #Dictionary }

{ #category : #'*GToolkit-Pharo-StrictSymbolComparison' }
Dictionary >> asGtStringContentDictionary [

	^ GtStringContentDictionary adoptInstance: self copy
]
