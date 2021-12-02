Extension { #name : #GtPharoSnippetCoder }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoSnippetCoder >> asCoderUIModel [
	^ GtPharoSnippetCoderViewModel new coder: self
]
