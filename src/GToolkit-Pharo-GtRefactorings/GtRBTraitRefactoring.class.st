Class {
	#name : #GtRBTraitRefactoring,
	#superclass : #RBRefactoring,
	#instVars : [
		'class',
		'traitName'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #'instance creation' }
GtRBTraitRefactoring class >> traitName: aString class: aClass [
	^ self new
		class: aClass traitName: aString;
		yourself
]

{ #category : #'initialize-release' }
GtRBTraitRefactoring >> class: aClass traitName: aString [
	class := self model classFor: aClass.
	class gtRemoveSlotsFromTraits.
	traitName := aString
]

{ #category : #private }
GtRBTraitRefactoring >> includesTrait: aString in: aRBClass [
	| expression |
	aRBClass traitExpression isNil
		ifTrue: [ ^ false ].
	expression := RBParser parseExpression: aRBClass traitExpression.
	expression
		nodesDo: [ :node | 
			(node isVariable and: [ node name = aString ])
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #preconditions }
GtRBTraitRefactoring >> preconditions [
	^ (RBCondition isMetaclass: class) not
		&
			(RBCondition
				withBlock: [ | trait |
					trait := Smalltalk globals
						at: traitName asSymbol
						ifAbsent: [ ^ self refactoringError: traitName , ' does not exist' ].
					trait isTrait
						ifFalse: [ ^ self refactoringError: traitName , ' is not a trait' ].
					true ])
]
