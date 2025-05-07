Class {
	#name : #GtVmMemoryConfigurationDataThreshold,
	#superclass : #Object,
	#instVars : [
		'thresholdValue'
	],
	#category : #'GToolkit-Pharo-System'
}

{ #category : #comparison }
GtVmMemoryConfigurationDataThreshold >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	
	^ self thresholdValue = anObject thresholdValue
]

{ #category : #accessing }
GtVmMemoryConfigurationDataThreshold >> thresholdValue [
	^thresholdValue
]

{ #category : #accessing }
GtVmMemoryConfigurationDataThreshold >> thresholdValue: anObject [
	thresholdValue := anObject
]
