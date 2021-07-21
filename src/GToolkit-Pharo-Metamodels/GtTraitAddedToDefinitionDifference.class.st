Class {
	#name : #GtTraitAddedToDefinitionDifference,
	#superclass : #GtTraitDifference,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Differences'
}

{ #category : #converting }
GtTraitAddedToDefinitionDifference >> asClassRefactorings: aClass in: anRBModel [
	^ GtRBAddTraitUsageRefactoring new
		model: anRBModel;
		class: aClass traitName: self traitName
]

{ #category : #printing }
GtTraitAddedToDefinitionDifference >> printOn: aStream [
	aStream
		nextPutAll: 'Added ';
		print: self traitName;
		nextPutAll: ' trait'
]
