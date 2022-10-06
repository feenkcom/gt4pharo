Class {
	#name : #GtClassVariableAddedDifference,
	#superclass : #GtClassVariableDifference,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Differences'
}

{ #category : #printing }
GtClassVariableAddedDifference >> printOn: aStream [
	aStream
		nextPutAll: 'Added ';
		print: self classVariableName;
		nextPutAll: ' class variable'
]
