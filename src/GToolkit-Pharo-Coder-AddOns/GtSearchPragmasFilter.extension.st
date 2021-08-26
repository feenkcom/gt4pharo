Extension { #name : 'GtSearchPragmasFilter' }

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtSearchPragmasFilter >> highlighter [
	^ GtPharoPragmaHighlighter forPragma: symbol
]
