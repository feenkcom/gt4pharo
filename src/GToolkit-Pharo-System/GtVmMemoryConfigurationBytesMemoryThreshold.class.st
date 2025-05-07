Class {
	#name : #GtVmMemoryConfigurationBytesMemoryThreshold,
	#superclass : #GtVmMemoryConfigurationDataThreshold,
	#category : #'GToolkit-Pharo-System'
}

{ #category : #comparison }
GtVmMemoryConfigurationBytesMemoryThreshold >> = anObject [
]

{ #category : #printing }
GtVmMemoryConfigurationBytesMemoryThreshold >> description [
	^ String streamContents: [ :aStream |
		self descriptionOn: aStream ]
]

{ #category : #printing }
GtVmMemoryConfigurationBytesMemoryThreshold >> descriptionOn: aStream [
	thresholdValue
		ifNotNil: [aStream nextPutAll: thresholdValue humanReadableIsqByteSize]
]

{ #category : #printing }
GtVmMemoryConfigurationBytesMemoryThreshold >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		self descriptionOn: aStream ]
]
