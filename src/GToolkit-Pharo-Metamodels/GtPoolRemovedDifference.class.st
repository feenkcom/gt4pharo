Class {
	#name : #GtPoolRemovedDifference,
	#superclass : #GtPoolDifference,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Differences'
}

{ #category : #printing }
GtPoolRemovedDifference >> printOn: aStream [
	aStream
		nextPutAll: 'Removed ';
		print: self poolName;
		nextPutAll: ' pool'
]
