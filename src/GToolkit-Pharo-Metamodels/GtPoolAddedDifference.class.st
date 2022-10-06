Class {
	#name : #GtPoolAddedDifference,
	#superclass : #GtPoolDifference,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Differences'
}

{ #category : #printing }
GtPoolAddedDifference >> printOn: aStream [
	aStream
		nextPutAll: 'Added ';
		print: self poolName;
		nextPutAll: ' pool'
]
