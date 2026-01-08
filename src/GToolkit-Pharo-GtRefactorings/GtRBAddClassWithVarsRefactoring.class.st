Class {
	#name : #GtRBAddClassWithVarsRefactoring,
	#superclass : #RBAddClassRefactoring,
	#instVars : [
		'instanceVariableNames',
		'classVariableNames',
		'superclassObject',
		'subclassObjects'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #initialization }
GtRBAddClassWithVarsRefactoring >> addClass: aName superclass: aClass subclasses: aCollection category: aSymbol [
	self className: aName.
	superclassObject := aClass.
	subclassObjects := OrderedCollection withAll: aCollection.
	category := aSymbol
]

{ #category : #transforming }
GtRBAddClassWithVarsRefactoring >> basicTransform [
	self model
		defineClassWithDefinition: ('<1s> subclass: #<2s> instanceVariableNames: <3p> classVariableNames: <4p> poolDictionaries: '''' category: <5p>'
				expandMacrosWithArguments: (Array
						with: superclass name
						with: className
						with: self instanceVariableNamesString
						with: self classVariableNamesString
						with: category asString));
		reparentClasses: subclasses to: (self model classNamed: className asSymbol)
]

{ #category : #accessing }
GtRBAddClassWithVarsRefactoring >> classVariableNames [
	^ classVariableNames
]

{ #category : #accessing }
GtRBAddClassWithVarsRefactoring >> classVariableNames: aCollection [
	classVariableNames := aCollection
]

{ #category : #accessing }
GtRBAddClassWithVarsRefactoring >> classVariableNamesString [
	^ String space join: self classVariableNames
]

{ #category : #initialize }
GtRBAddClassWithVarsRefactoring >> initialize [
	super initialize.
	instanceVariableNames := OrderedCollection new.
	classVariableNames := OrderedCollection new
]

{ #category : #accessing }
GtRBAddClassWithVarsRefactoring >> instanceVariableNames [
	^ instanceVariableNames
]

{ #category : #accessing }
GtRBAddClassWithVarsRefactoring >> instanceVariableNames: aCollection [
	instanceVariableNames := aCollection
]

{ #category : #accessing }
GtRBAddClassWithVarsRefactoring >> instanceVariableNamesString [
	^ String space join: self instanceVariableNames
]

{ #category : #preconditions }
GtRBAddClassWithVarsRefactoring >> preconditions [
	| preconditions |
	preconditions := self instanceVariableNames inject: super preconditions into: [ :pre :each | 
		pre 
			& (RBCondition isValidInstanceVariableName: each for: superclass) 
			& (RBCondition definesInstanceVariable: each in: superclass ) not 
			& (RBCondition isGlobal: each in: self model) not ].
	^ self classVariableNames inject: preconditions into: [ :pre :each | 
		pre 
			"& (RBCondition isValidClassVarName: each for: class ) "
			& (RBCondition definesClassVariable: each in: superclass ) not 
			& (RBCondition isGlobal: each in: self model) not	 ]
]

{ #category : #transforming }
GtRBAddClassWithVarsRefactoring >> prepareForExecution [
	superclass := self classObjectFor: superclassObject.
	subclasses := subclassObjects collect: [ :each | self classObjectFor: each ].
	super prepareForExecution
]

{ #category : #transforming }
GtRBAddClassWithVarsRefactoring >> privateTransform [
	self basicTransform
]

{ #category : #transforming }
GtRBAddClassWithVarsRefactoring >> transform [
	self basicTransform
]
