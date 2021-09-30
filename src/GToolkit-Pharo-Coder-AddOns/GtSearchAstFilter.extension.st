Extension { #name : #GtSearchAstFilter }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSearchAstFilter >> highlighter [
	^ GtRBPatternHighlighter new
		  ast: self ast;
		  yourself
]
