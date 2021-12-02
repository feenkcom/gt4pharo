Class {
	#name : #GtAsyncSearchMethodGroupStream,
	#superclass : #GtAsyncSearchTypedGroupStream,
	#category : #'GToolkit-Pharo-Coder-Filters - Stream'
}

{ #category : #'*GToolkit-Pharo-Coder' }
GtAsyncSearchMethodGroupStream >> asCoder [
	^ GtFilteredMethodsCoder forFilter: self filter
]
