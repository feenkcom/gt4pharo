Class {
	#name : #GtSearchClassSlotReferenceFilter,
	#superclass : #GtSearchInstanceSlotReferenceFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #printing }
GtSearchClassSlotReferenceFilter >> gtDisplayOn: stream [
	stream
		print: class;
		nextPut: $.;
		nextPutAll: variableName asString;
		nextPutAll: ' classSlotReferences'
]
