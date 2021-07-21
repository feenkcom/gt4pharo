Class {
	#name : #GtTraitRemovedFromDefinitionDifference,
	#superclass : #GtTraitDifference,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Differences'
}

{ #category : #converting }
GtTraitRemovedFromDefinitionDifference >> asClassRefactorings: aClass in: anRBModel [
	^ GtRBRemoveTraitUsageRefactoring new
		model: anRBModel;
		class: aClass traitName: self traitName
]

{ #category : #printing }
GtTraitRemovedFromDefinitionDifference >> printOn: aStream [
	aStream
		nextPutAll: 'Removed ';
		print: self traitName;
		nextPutAll: ' trait'
]
