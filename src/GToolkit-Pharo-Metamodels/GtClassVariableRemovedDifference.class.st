Class {
	#name : #GtClassVariableRemovedDifference,
	#superclass : #GtClassVariableDifference,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Differences'
}

{ #category : #printing }
GtClassVariableRemovedDifference >> printOn: aStream [
	aStream
		nextPutAll: 'Removed ';
		print: self classVariableName;
		nextPutAll: ' class variable'
]
