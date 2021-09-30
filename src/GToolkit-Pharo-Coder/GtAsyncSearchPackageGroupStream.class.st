Class {
	#name : #GtAsyncSearchPackageGroupStream,
	#superclass : #GtAsyncSearchTypedGroupStream,
	#category : 'GToolkit-Pharo-Coder-Filters - Stream'
}

{ #category : #updating }
GtAsyncSearchPackageGroupStream >> updateItems [
	itemsStream := scope filter: filter.
	itemsFuture := itemsStream collect map: [ :thePackages | thePackages sorted: [ :a :b | a name < b name ] ]
]
