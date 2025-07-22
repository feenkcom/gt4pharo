Class {
	#name : #GtRBMoveClassToPackageRefactoring,
	#superclass : #RBClassTransformation,
	#instVars : [
		'packageName'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #'instance creation' }
GtRBMoveClassToPackageRefactoring class >> model: aRBModel move: aClassName to: aPackageName [
	^ self new
		model: aRBModel;
		move: aClassName to: aPackageName;
		yourself
]

{ #category : #'instance creation' }
GtRBMoveClassToPackageRefactoring class >> move: aClassName to: aPackageName [
	^ self new
		move: aClassName to: aPackageName;
		yourself
]

{ #category : #executing }
GtRBMoveClassToPackageRefactoring >> ensurePackageCreated [
	(self isPackage: packageName)
		ifTrue: [ ^ self ].
	model changes addChange: (GtRBAddPackageChange packageName: packageName)
]

{ #category : #testing }
GtRBMoveClassToPackageRefactoring >> isPackage: aSymbol [
	self packageOrganizer
		packageNamed: aSymbol
		ifAbsent: [ | index |
			index := aSymbol lastIndexOf: $-.
			index < 1
				ifTrue: [ ^ false ].
			^ self isPackage: (aSymbol first: index - 1) asSymbol ].
	^ true
]

{ #category : #'initialize-release' }
GtRBMoveClassToPackageRefactoring >> move: aClassName to: aPackageName [
	self className: aClassName.
	packageName := aPackageName
]

{ #category : #preconditions }
GtRBMoveClassToPackageRefactoring >> preconditions [
	^ (RBCondition
		withBlock: [ self definingClass isNotNil ]
		errorString: 'Class named ' , className , ' does not exist')
		&
			(RBCondition
				withBlock: [ packageName notNil and: [ packageName notEmpty ] ]
				errorString: 'Not a valid package name')
]

{ #category : #executing }
GtRBMoveClassToPackageRefactoring >> privateTransform [
	self ensurePackageCreated.
	self definingClass category: packageName.
	self model changes
		addChange: (GtRBClassPackageChange category: packageName for: self definingClass)
]
