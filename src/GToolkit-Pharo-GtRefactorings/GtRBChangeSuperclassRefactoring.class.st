Class {
	#name : #GtRBChangeSuperclassRefactoring,
	#superclass : #RBClassRefactoring,
	#instVars : [
		'class',
		'newSuperclass',
		'newSuperclassName'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #'instance creation' }
GtRBChangeSuperclassRefactoring class >> changeSuperclassOf: aClass to: superClass [
	^ self new
		changeSuperclassOf: aClass to: superClass;
		yourself
]

{ #category : #'instance creation' }
GtRBChangeSuperclassRefactoring class >> model: aNamespace changeSuperclassOf: aClass to: superClass [
	^ self new
		model: aNamespace;
		changeSuperclassOf: aClass to: superClass;
		yourself
]

{ #category : #transforming }
GtRBChangeSuperclassRefactoring >> basicTransform [
	class superclass: newSuperclass.
	class classSide superclass: newSuperclass classSide.
	self model defineClassWithDefinition: class gtDefinitionString
]

{ #category : #'initialize-release' }
GtRBChangeSuperclassRefactoring >> changeSuperclassOf: aClass to: superClass [
	className := self nameOf: aClass.
	newSuperclassName := self nameOf: superClass
]

{ #category : #accessing }
GtRBChangeSuperclassRefactoring >> gtDescription [
	<return: #String or: #BlRunRopedText>
	^ 'Change' asRopedText glamorousRoundedBackground
		append: ' superclass of ' asRopedText;
		append: className asRopedText;
		append: ' to ' asRopedText;
		append: newSuperclassName asRopedText glamorousRoundedBackground
]

{ #category : #private }
GtRBChangeSuperclassRefactoring >> nameOf: anObject [
	^ anObject isString ifTrue: [ anObject ] ifFalse: [ anObject name ]
]

{ #category : #preconditions }
GtRBChangeSuperclassRefactoring >> preconditions [
	^ (RBCondition isMetaclass: class) not
		& (RBCondition isMetaclass: newSuperclass) not
		& (RBCondition
				withBlock: [ (newSuperclass withAllSuperclasses includes: class)
						ifTrue: [ ^ self
								refactoringError: 'Assigning superclass ' , newSuperclass name , ' to ' , className
										, ' would create a cycle in the hierarchy' ].
					true ])
]

{ #category : #transforming }
GtRBChangeSuperclassRefactoring >> prepareForExecution [
	class := self classObjectFor: className.
	class gtRemoveSlotsFromTraits.
	newSuperclass := self classObjectFor: newSuperclassName.
	super prepareForExecution
]

{ #category : #transforming }
GtRBChangeSuperclassRefactoring >> privateTransform [
	self basicTransform
]

{ #category : #transforming }
GtRBChangeSuperclassRefactoring >> transform [
	self basicTransform
]
