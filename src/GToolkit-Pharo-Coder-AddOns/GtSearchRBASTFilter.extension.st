Extension { #name : #GtSearchRBASTFilter }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSearchRBASTFilter >> highlighter [
	^ GtRBPatternHighlighter new
		  ast: self ast;
		  yourself
]
