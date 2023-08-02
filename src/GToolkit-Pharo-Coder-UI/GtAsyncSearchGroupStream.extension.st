Extension { #name : #GtAsyncSearchGroupStream }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtAsyncSearchGroupStream >> asCoder [
	^ GtFilteredMethodsCoder forFilter: self filter
]
