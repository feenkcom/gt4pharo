Class {
	#name : #GtSlotsDefinitionDifference,
	#superclass : #GtCompositeDefinitionDifference,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Differences'
}

{ #category : #printing }
GtSlotsDefinitionDifference >> printOn: aStream [
	aStream nextPutAll: 'Slots'
]
