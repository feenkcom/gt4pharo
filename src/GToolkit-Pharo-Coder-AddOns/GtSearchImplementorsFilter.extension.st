Extension { #name : 'GtSearchImplementorsFilter' }

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtSearchImplementorsFilter >> highlighter [
	^ GtPharoImplementorHighlighter forSelector: selector
]
