Class {
	#name : #GtClassSlotsDefinition,
	#superclass : #GtSlotsDefinition,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Definitions'
}

{ #category : #accessing }
GtClassSlotsDefinition >> modelClassFrom: aModel [
	^ (aModel classNamed: self definition topMostParent name) classSide
]

{ #category : #'gt - editors' }
GtClassSlotsDefinition >> title [
	^ 'Class Slots'
]
