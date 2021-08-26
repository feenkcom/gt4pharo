Extension { #name : 'GtSubstringFilter' }

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtSubstringFilter >> highlighter [
	^ GtPharoSubstringHighlighter substring: self substring
]
