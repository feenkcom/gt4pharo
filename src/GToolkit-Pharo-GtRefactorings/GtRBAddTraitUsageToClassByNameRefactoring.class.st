Class {
	#name : #GtRBAddTraitUsageToClassByNameRefactoring,
	#superclass : #RBRefactoring,
	#instVars : [
		'className',
		'traitName'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #'instance creation' }
GtRBAddTraitUsageToClassByNameRefactoring class >> traitName: aTraitName inClassNamed: aClassName [
	^ self new
		className: aClassName asSymbol 
		traitName: aTraitName asSymbol
]

{ #category : #transforming }
GtRBAddTraitUsageToClassByNameRefactoring >> basicTransform [
	| newExpression class |
	class := self model classNamed: className.
	newExpression := class traitExpression
			ifNil: [ traitName ]
			ifNotNil: [ :exp | exp , ' + ' , traitName ].
	class traitExpression: newExpression.
	self model changes defineClass: class gtDefinitionString
]

{ #category : #private }
GtRBAddTraitUsageToClassByNameRefactoring >> checkClassDoesNotIncludeTraitFor: aClass [ 
	aClass withAllSuperclasses
		do: [ :each | 
			(self includesTrait: traitName in: each)
				ifTrue: [ ^ self
						refactoringError: traitName , ' is already included in ' , each name ] ]
]

{ #category : #'initialize-release' }
GtRBAddTraitUsageToClassByNameRefactoring >> className: aClassName traitName: aTraitName [
	className := aClassName.
	traitName := aTraitName
]

{ #category : #private }
GtRBAddTraitUsageToClassByNameRefactoring >> includesTrait: aString in: aRBClass [
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
GtRBAddTraitUsageToClassByNameRefactoring >> preconditions [
	| class |
	class := (self model classNamed: className) asClassWithTrait.
	
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
		&
			(RBCondition
				withBlock: [ self checkClassDoesNotIncludeTraitFor: class.
					true ])
]

{ #category : #transforming }
GtRBAddTraitUsageToClassByNameRefactoring >> privateTranform [
	self basicTransform
]

{ #category : #transforming }
GtRBAddTraitUsageToClassByNameRefactoring >> transform [
	self basicTransform
]
