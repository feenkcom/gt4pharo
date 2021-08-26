Extension { #name : 'GtSearchImplementorPatternFilter' }

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtSearchImplementorPatternFilter >> highlighter [
	pattern isEmpty
		ifTrue: [ ^ super highlighter ].
	^ GtPharoImplementorPatternHighlighter forPattern: pattern
]
