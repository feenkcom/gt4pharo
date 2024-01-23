Extension { #name : #GtSearchLiteralValueFilter }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSearchLiteralValueFilter >> highlighter [
	^ GtPharoLiteralValueHighlighter 
		literalValue:  self literalValue
]
