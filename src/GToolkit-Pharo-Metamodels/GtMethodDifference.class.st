Class {
	#name : #GtMethodDifference,
	#superclass : #GtCodeDefinitionDifference,
	#instVars : [
		'method'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Differences'
}

{ #category : #accessing }
GtMethodDifference >> method [
	^ method
]

{ #category : #accessing }
GtMethodDifference >> method: anObject [
	method := anObject
]
