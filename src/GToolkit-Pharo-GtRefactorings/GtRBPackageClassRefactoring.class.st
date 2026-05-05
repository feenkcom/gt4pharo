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

{ #category : #preconditions }
GtRBPackageClassRefactoring >> applicabilityPreconditions [
	| conds |
	conds := OrderedCollection new.
	conds add: (RBCondition isMetaclass: class) not.
	conds
		add: (RBCondition
				withBlock: [ packageName notNil and: [ packageName notEmpty ] ]
				errorString: 'Not a valid package name').
	^ self
		forPharo13AndNewer: [ conds ]
		forOlder: [ conds inject: RBCondition true into: [ :sum :each | sum & each ] ]
]

{ #category : #transforming }
GtRBPackageClassRefactoring >> basicTransform [
	self packageOrganizer
		packageNamed: packageName asSymbol
		ifAbsent: [ self model changes addChange: (GtRBAddPackageChange packageName: packageName) ].
	class
		category: packageName
				, ((tagName isNil or: [ tagName isEmpty ])
						ifTrue: [ '' ]
						ifFalse: [ '-' , tagName ]).
	self model defineClass: class gtDefinitionString
]

{ #category : #'initialize-release' }
GtRBPackageClassRefactoring >> class: aClass packageName: packageString tagName: tagString [
	class := self model classFor: aClass.
	className := class name.
	packageName := packageString.
	tagName := tagString
]

{ #category : #transforming }
GtRBPackageClassRefactoring >> privateTransform [
	self basicTransform
]

{ #category : #transforming }
GtRBPackageClassRefactoring >> transform [
	self basicTransform
]
