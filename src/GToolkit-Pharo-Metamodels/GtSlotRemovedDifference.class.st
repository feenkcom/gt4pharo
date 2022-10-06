Class {
	#name : #GtSlotRemovedDifference,
	#superclass : #GtSlotDifference,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Differences'
}

{ #category : #printing }
GtSlotRemovedDifference >> printOn: aStream [
	aStream
		nextPutAll: 'Removed ';
		print: self slotName;
		nextPutAll: ' slot'
]
