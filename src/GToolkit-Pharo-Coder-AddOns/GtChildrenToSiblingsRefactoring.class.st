Class {
	#name : #GtChildrenToSiblingsRefactoring,
	#superclass : #RBChildrenToSiblingsRefactoring,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #transforming }
GtChildrenToSiblingsRefactoring >> addSuperclass [
	| definition |
	definition := String
			streamContents: [ :stream | 
				stream << parent superclass name << ' << ' << className printString
					<< ' slots: {'.
				parent instanceVariableNames
					do: [ :each | stream << '#' << each ]
					separatedBy: [ stream << '. ' ].
				stream << '}; sharedVariables: {'.
				parent classVariableNames
					do: [ :each | stream << '#' << each ]
					separatedBy: [ stream << '. ' ].
				stream << '}; sharedPools: {'.
				parent poolDictionaryNames
					do: [ :each | stream << '#' << each ]
					separatedBy: [ stream << '. ' ].
				stream << '}; package: ' << parent category printString ].
	self model defineClass: definition.
	definition := String
			streamContents: [ :stream | 
				stream << className << ' << ' << parent name printString
					<< ' slots: {}; sharedVariables: {}; sharedPools: {}; package: '
					<< parent category printString ].
	self model defineClass: definition
]

{ #category : #transforming }
GtChildrenToSiblingsRefactoring >> pushUpVariables [
	"Instance side is handled when the new class is added."
	self pullUpClassInstanceVariables
]

{ #category : #'private - methods' }
GtChildrenToSiblingsRefactoring >> shouldPushUp: aSelector from: aClass [
	subclasses isEmpty ifTrue: [ ^ true ].
	^ (aClass isMeta
		ifTrue: [ subclasses collect: [ :each | each classSide ] ]
		ifFalse: [ subclasses ])
		anySatisfy: [ :each | (each directlyDefinesMethod: aSelector) not ]
]
