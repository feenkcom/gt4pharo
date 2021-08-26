Extension { #name : 'GtSearchLiteralStringFilter' }

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtSearchLiteralStringFilter >> highlighter [
	^ GtPharoSubstringLiteralHighlighter 
		substring: self substring
		caseSensitive: self caseSensitive
]
