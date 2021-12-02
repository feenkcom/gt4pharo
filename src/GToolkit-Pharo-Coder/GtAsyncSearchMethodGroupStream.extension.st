Extension { #name : #GtAsyncSearchMethodGroupStream }

{ #category : #'*GToolkit-Pharo-Coder' }
GtAsyncSearchMethodGroupStream >> asCoder [
	^ GtFilteredMethodsCoder forFilter: self filter
]
