"
I am a refactoring for replacing every direct access to  class variables with accessor methods.

My precondition verifies that the variable is directly defined in that class.
I create new accessor methods for the variables and replace every read and write to this variable with the new accessors.

"
Class {
	#name : #RBAbstractClassVariableRefactoring,
	#superclass : #RBVariableRefactoring,
	#instVars : [
		'accessorsRefactoring'
	],
	#category : #'GToolkit-Pharo-BaseRefactorings'
}

{ #category : #transforming }
RBAbstractClassVariableRefactoring >> abstractClassReferences [
	| replacer |
	replacer := self parseTreeRewriterClass  
		variable: variableName
		getter: self accessorsRefactoring getterMethod
		setter: self accessorsRefactoring setterMethod.
	self 
		convertClasses: class classSide withAllSubclasses
		select: 
			[ :aClass | 
			(aClass whichSelectorsReferToClassVariable: variableName) reject: 
				[ :each | 
				aClass == class classSide and: 
					[ each == self accessorsRefactoring getterMethod or: [ each == self accessorsRefactoring setterMethod ] ] ] ]
		using: replacer
]

{ #category : #transforming }
RBAbstractClassVariableRefactoring >> abstractInstanceReferences [
	| replacer |
	replacer := self parseTreeRewriterClass 
		variable: variableName
		getter: 'class ' , self accessorsRefactoring getterMethod
		setter: 'class ' , self accessorsRefactoring setterMethod.
	self 
		convertClasses: class withAllSubclasses
		select: [ :aClass | aClass whichSelectorsReferToClassVariable: variableName ]
		using: replacer
]

{ #category : #'private - accessing' }
RBAbstractClassVariableRefactoring >> accessorsRefactoring [

	^ accessorsRefactoring
		ifNil: [ accessorsRefactoring := RBCreateAccessorsForVariableRefactoring
				model: self model
				variable: variableName asString
				class: class
				classVariable: true
			]
		ifNotNil: [ accessorsRefactoring ]
]

{ #category : #transforming }
RBAbstractClassVariableRefactoring >> basicTransform [
	self createAccessors.
	self abstractInstanceReferences.
	self abstractClassReferences
]

{ #category : #transforming }
RBAbstractClassVariableRefactoring >> createAccessors [
	self performCompositeRefactoring: self accessorsRefactoring
]

{ #category : #accessing }
RBAbstractClassVariableRefactoring >> gtDescription [
	^ 'Abstract class variable ' , variableName
]

{ #category : #preconditions }
RBAbstractClassVariableRefactoring >> preconditions [
	^(RBCondition isMetaclass: class) not 
		& (RBCondition directlyDefinesClassVariable: variableName asSymbol in: class) 
			& ((RBCondition withBlock: 
						[(#(#Object #Behavior #ClassDescription #Class) includes: class name) not]) 
					errorMacro: 'This refactoring does not work for Object, Behavior, ClassDescription, or Class')
]

{ #category : #transforming }
RBAbstractClassVariableRefactoring >> privateTransform [
	self basicTransform
]

{ #category : #transforming }
RBAbstractClassVariableRefactoring >> transform [
	self basicTransform
]
