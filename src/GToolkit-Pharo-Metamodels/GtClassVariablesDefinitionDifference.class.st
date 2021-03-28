Class {
	#name : #GtClassVariablesDefinitionDifference,
	#superclass : #GtCompositeDefinitionDifference,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Differences'
}

{ #category : #printing }
GtClassVariablesDefinitionDifference >> printOn: aStream [
	aStream nextPutAll: 'Variables'
]
