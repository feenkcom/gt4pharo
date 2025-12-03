Class {
	#name : #GtInlineMethodRefactoring,
	#superclass : #RBInlineMethodRefactoring,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #transforming }
GtInlineMethodRefactoring >> insertInlinedMethod [
	super insertInlinedMethod.
	self removeUnnecessaryAssignments
]
