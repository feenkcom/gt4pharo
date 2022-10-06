Class {
	#name : #GtTraitRemovedFromDefinitionDifference,
	#superclass : #GtTraitDifference,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Differences'
}

{ #category : #printing }
GtTraitRemovedFromDefinitionDifference >> printOn: aStream [
	aStream
		nextPutAll: 'Removed ';
		print: self traitName;
		nextPutAll: ' trait'
]
