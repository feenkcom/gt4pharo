Class {
	#name : #GtClassSuperclassDefinitionDifference,
	#superclass : #GtCodeDefinitionDifference,
	#instVars : [
		'oldName',
		'newName'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Differences'
}

{ #category : #converting }
GtClassSuperclassDefinitionDifference >> asClassRefactorings: aClass in: anRBModel [
	^ GtRBChangeSuperclassRefactoring new
		model: anRBModel;
		changeSuperclassOf: aClass to: (anRBModel classNamed: newName)
]

{ #category : #accessing }
GtClassSuperclassDefinitionDifference >> newName [
	^ newName
]

{ #category : #accessing }
GtClassSuperclassDefinitionDifference >> newName: anObject [
	newName := anObject
]

{ #category : #accessing }
GtClassSuperclassDefinitionDifference >> oldName [
	^ oldName
]

{ #category : #accessing }
GtClassSuperclassDefinitionDifference >> oldName: anObject [
	oldName := anObject
]

{ #category : #printing }
GtClassSuperclassDefinitionDifference >> printOn: aStream [
	aStream
		nextPutAll: 'Superclass changed from ';
		print: self oldName;
		nextPutAll: ' to ';
		print: self newName
]
