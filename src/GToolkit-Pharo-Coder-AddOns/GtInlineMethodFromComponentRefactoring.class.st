Class {
	#name : #GtInlineMethodFromComponentRefactoring,
	#superclass : #RBInlineMethodFromComponentRefactoring,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #transforming }
GtInlineMethodFromComponentRefactoring >> insertInlinedMethod [
	super insertInlinedMethod.
	self removeUnnecessaryAssignments
]
