Class {
	#name : #GtTraitDifference,
	#superclass : #GtCodeDefinitionDifference,
	#instVars : [
		'traitName'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Differences'
}

{ #category : #accessing }
GtTraitDifference >> traitName [
	^ traitName
]

{ #category : #accessing }
GtTraitDifference >> traitName: anObject [
	traitName := anObject
]
