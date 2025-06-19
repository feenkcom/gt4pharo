Class {
	#name : #GtRBRenamePackageTagRefactoring,
	#superclass : #RBRefactoring,
	#instVars : [
		'packageName',
		'oldName',
		'newName'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #'instace creation' }
GtRBRenamePackageTagRefactoring class >> packageName: aPackageName from: oldTagName to: newTagName [
	^ self new
		packageName: aPackageName from: oldTagName to: newTagName;
		yourself
]

{ #category : #transforming }
GtRBRenamePackageTagRefactoring >> basicTransform [
	self model changes
		addChange: (GtRBRenamePackageTagChange
				packageName: packageName
				from: oldName
				to: newName)
]

{ #category : #accessing }
GtRBRenamePackageTagRefactoring >> gtDescription [
	^ 'Rename package tag ' , oldName , ' to ' , newName
]

{ #category : #'initialize-release' }
GtRBRenamePackageTagRefactoring >> packageName: aPackageName from: oldTagName to: newTagName [
	packageName := aPackageName.
	oldName := oldTagName.
	newName := newTagName
]

{ #category : #preconditions }
GtRBRenamePackageTagRefactoring >> preconditions [
	| package |
	package := self packageOrganizer
		packageNamed: packageName asSymbol
		ifAbsent: [  ].
	^ ((RBCondition withBlock: [ package notNil ])
		errorMacro: 'Package ' , packageName , ' does not exist')
		&
			((RBCondition
				withBlock:
					[ (package classTagNamed: oldName asSymbol ifAbsent: [  ]) notNil ])
				errorMacro: 'Package tag ' , oldName , ' does not exist')
		&
			((RBCondition
				withBlock:
					[ (package classTagNamed: newName asSymbol ifAbsent: [  ]) isNil ])
				errorMacro: 'Package tag ' , newName , ' already exists')
]

{ #category : #transforming }
GtRBRenamePackageTagRefactoring >> privateTransform [
	self basicTransform
]

{ #category : #transforming }
GtRBRenamePackageTagRefactoring >> transform [
	self basicTransform
]
