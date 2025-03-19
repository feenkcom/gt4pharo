Extension { #name : #GtMethodContextsCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtMethodContextsCoder >> asCoderViewModel [
	^ GtPharoMethodContextsCoderViewModel new coder: self
]
