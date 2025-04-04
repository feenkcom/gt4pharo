Class {
	#name : #GtChildrenToSiblingsRefactoring,
	#superclass : #RBChildrenToSiblingsRefactoring,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #'private - methods' }
GtChildrenToSiblingsRefactoring >> shouldPushUp: aSelector from: aClass [
	subclasses isEmpty ifTrue: [ ^ true ].
	^ (aClass isMeta
		ifTrue: [ subclasses collect: [ :each | each classSide ] ]
		ifFalse: [ subclasses ])
		anySatisfy: [ :each | (each directlyDefinesMethod: aSelector) not ]
]
