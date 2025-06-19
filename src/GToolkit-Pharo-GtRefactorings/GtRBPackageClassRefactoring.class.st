Class {
	#name : #GtRBPackageClassRefactoring,
	#superclass : #RBClassRefactoring,
	#instVars : [
		'class',
		'packageName',
		'tagName'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #'instance creation' }
GtRBPackageClassRefactoring class >> class: aClass packageName: packageString tagName: tagString [
	^ self new
		class: aClass packageName: packageString tagName: tagString;
		yourself
]

{ #category : #transforming }
GtRBPackageClassRefactoring >> basicTransform [
	RPackageOrganizer default
		packageNamed: packageName asSymbol
		ifAbsent: [ self model changes addChange: (GtRBAddPackageChange packageName: packageName) ].
	class
		category: packageName
				, ((tagName isNil or: [ tagName isEmpty ])
						ifTrue: [ '' ]
						ifFalse: [ '-' , tagName ]).
	self model changes defineClass: class gtDefinitionString
]

{ #category : #'initialize-release' }
GtRBPackageClassRefactoring >> class: aClass packageName: packageString tagName: tagString [
	class := self model classFor: aClass.
	className := class name.
	packageName := packageString.
	tagName := tagString
]

{ #category : #preconditions }
GtRBPackageClassRefactoring >> preconditions [
	^ (RBCondition isMetaclass: class) not
]

{ #category : #transforming }
GtRBPackageClassRefactoring >> privateTranform [
	self basicTransform
]

{ #category : #transforming }
GtRBPackageClassRefactoring >> transform [
	self basicTransform
]
