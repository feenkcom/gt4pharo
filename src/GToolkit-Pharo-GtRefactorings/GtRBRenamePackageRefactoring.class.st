Class {
	#name : #GtRBRenamePackageRefactoring,
	#superclass : #RBRefactoring,
	#instVars : [
		'oldName',
		'newName'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #'instance creation' }
GtRBRenamePackageRefactoring class >> from: oldName to: newName [
	^ self new
		from: oldName to: newName;
		yourself
]

{ #category : #'initialize-release' }
GtRBRenamePackageRefactoring >> from: oldPackageName to: newPackageName [
	oldName := oldPackageName.
	newName := newPackageName
]

{ #category : #accessing }
GtRBRenamePackageRefactoring >> gtDescription [
	^ 'Rename package ' , oldName , ' to ' , newName
]

{ #category : #transforming }
GtRBRenamePackageRefactoring >> manifestClassNameFor: aPackageName [
	"Returns a symbol representing a suitable name for a Manifest class for the given package"
	
	^('Manifest', (aPackageName select: [:each | each isAlphaNumeric ])) asSymbol
]

{ #category : #accessing }
GtRBRenamePackageRefactoring >> preconditions [
	^ ((RBCondition
		withBlock: [ (self packageOrganizer packageNamed: oldName asSymbol ifAbsent: [  ])
				notNil ]) errorMacro: 'Package ' , oldName , ' does not exist')
		&
			((RBCondition
				withBlock: [ (self packageOrganizer packageNamed: newName asSymbol ifAbsent: [  ])
						isNil ]) errorMacro: 'Package ' , newName , ' already exists')
]

{ #category : #transforming }
GtRBRenamePackageRefactoring >> renameBaselineReferences [
	| rewriter baselineClass |
	baselineClass := self model classNamed: #BaselineOf.
	baselineClass isNil ifTrue: [ ^ self ].
	rewriter := RBParseTreeRewriter new.
	rewriter
		replace: oldName asString storeString
		with: newName asString storeString
		when: [ :node | node gtIsBaselinePackageName ].
	rewriter
		replace: oldName asSymbol storeString
		with: newName asSymbol storeString
		when: [ :node | node gtIsBaselinePackageName ].
	baselineClass withAllSubclasses
		do: [ :each | 
			| selectors |
			selectors := Set
					withAll: (each whichSelectorsReferToSymbol: oldName asString).
			selectors addAll: (each whichSelectorsReferToSymbol: oldName asSymbol).
			selectors
				do: [ :sel | 
					| method |
					method := each methodFor: sel.
					(rewriter executeTree: method ast)
						ifTrue: [ method compileTree: rewriter tree ] ] ]
]

{ #category : #transforming }
GtRBRenamePackageRefactoring >> renameManifestClass [
	| refactoring manifest |
	manifest := self model classNamed: (self manifestClassNameFor: oldName).
	manifest
		ifNotNil: [ refactoring := GtRBRenameClassRefactoring
					model: self model
					rename: manifest name
					to: (self manifestClassNameFor: newName).
			self performCompositeRefactoring: refactoring ]
]

{ #category : #transforming }
GtRBRenamePackageRefactoring >> renamePackage [
	self model changes
		addChange: (GtRBRenamePackageChange from: oldName to: newName)
]

{ #category : #transforming }
GtRBRenamePackageRefactoring >> transform [
	self renamePackage.
	self renameManifestClass.
	self renameBaselineReferences
]
