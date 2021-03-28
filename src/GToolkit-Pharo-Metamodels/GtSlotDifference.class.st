Class {
	#name : #GtSlotDifference,
	#superclass : #GtCodeDefinitionDifference,
	#instVars : [
		'slotName'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Differences'
}

{ #category : #accessing }
GtSlotDifference >> slotName [
	^ slotName
]

{ #category : #accessing }
GtSlotDifference >> slotName: anObject [
	slotName := anObject
]
