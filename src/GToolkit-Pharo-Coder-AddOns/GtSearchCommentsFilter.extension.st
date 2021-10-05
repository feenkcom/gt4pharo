Extension { #name : #GtSearchCommentsFilter }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSearchCommentsFilter >> highlighter [
	^ GtPharoCommentsReferenceHighlighter new commentsFilter: self
]
