Class {
	#name : #GtPoolDifference,
	#superclass : #GtCodeDefinitionDifference,
	#instVars : [
		'poolName'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Differences'
}

{ #category : #accessing }
GtPoolDifference >> poolName [
	^ poolName
]

{ #category : #accessing }
GtPoolDifference >> poolName: anObject [
	poolName := anObject
]
