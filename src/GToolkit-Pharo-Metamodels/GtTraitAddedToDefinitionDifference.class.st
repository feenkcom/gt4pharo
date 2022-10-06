Class {
	#name : #GtTraitAddedToDefinitionDifference,
	#superclass : #GtTraitDifference,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Differences'
}

{ #category : #printing }
GtTraitAddedToDefinitionDifference >> printOn: aStream [
	aStream
		nextPutAll: 'Added ';
		print: self traitName;
		nextPutAll: ' trait'
]
