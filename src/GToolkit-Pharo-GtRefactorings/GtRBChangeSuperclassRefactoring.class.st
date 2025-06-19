Class {
	#name : #GtRBChangeSuperclassRefactoring,
	#superclass : #RBClassRefactoring,
	#instVars : [
		'class',
		'newSuperclass'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #'instance creation' }
GtRBChangeSuperclassRefactoring class >> changeSuperclassOf: aClass to: superClass [
	^ self new
		changeSuperclassOf: aClass to: superClass;
		yourself
]

{ #category : #transforming }
GtRBChangeSuperclassRefactoring >> basicTransform [
	class superclass: newSuperclass.
	class classSide superclass: newSuperclass classSide.
	self model changes defineClass: class gtDefinitionString
]

{ #category : #'initialize-release' }
GtRBChangeSuperclassRefactoring >> changeSuperclassOf: aClass to: superClass [
	className := aClass name.
	class := self model classFor: aClass.
	class gtRemoveSlotsFromTraits.
	newSuperclass := self model classFor: superClass
]

{ #category : #accessing }
GtRBChangeSuperclassRefactoring >> gtDescription [
	<return: #String or: #BlRunRopedText>
	
	^ ('Change' asRopedText glamorousRoundedBackground)
		append: ' superclass of ' asRopedText;
		append: className asRopedText;
		append: ' to ' asRopedText;
		append: newSuperclass name asRopedText glamorousRoundedBackground
]

{ #category : #preconditions }
GtRBChangeSuperclassRefactoring >> preconditions [
	^ (RBCondition isMetaclass: class) not
		& (RBCondition isMetaclass: newSuperclass) not
		&
			(RBCondition
				withBlock: [ (newSuperclass withAllSuperclasses includes: class)
						ifTrue: [ ^ self
								refactoringError:
									'Assigning superclass ' , newSuperclass name , ' to ' , class name
										, ' would create a cycle in the hierarchy' ].
					true ])
]

{ #category : #transforming }
GtRBChangeSuperclassRefactoring >> privateTransform [
	self basicTransform
]

{ #category : #transforming }
GtRBChangeSuperclassRefactoring >> transform [
	self basicTransform
]
