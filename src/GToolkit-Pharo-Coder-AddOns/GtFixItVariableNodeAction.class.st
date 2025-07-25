Class {
	#name : #GtFixItVariableNodeAction,
	#superclass : #GtFixItAction,
	#category : #'GToolkit-Pharo-Coder-AddOns-FixIt'
}

{ #category : #'api - node' }
GtFixItVariableNodeAction >> nodeName [
	^ node variableName
]
