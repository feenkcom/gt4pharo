Extension { #name : #GtSearchLiteralValueFilter }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSearchLiteralValueFilter >> highlighter [
	^ GtPharoSubstringHighlighter 
		substring:  self literalValue printString
]
