Extension { #name : #GtSearchLiteralExactStringFilter }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSearchLiteralExactStringFilter >> highlighter [

	^ GtPharoStringLiteralHighlighter
		  string: self string
		  caseSensitive: self caseSensitive
]
