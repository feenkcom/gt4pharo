Class {
	#name : #GtAsyncSearchClassGroupStream,
	#superclass : #GtAsyncSearchTypedGroupStream,
	#category : #'GToolkit-Pharo-Coder-Filters - Stream'
}

{ #category : #updating }
GtAsyncSearchClassGroupStream >> updateItems [
	itemsStream := scope filter: filter.
	itemsFuture := itemsStream collect map: [ :theMethods | theMethods sorted: [ :a :b | a name > b name ] ]
]
