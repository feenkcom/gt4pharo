Class {
	#name : #GtRBRenamePackageChange,
	#superclass : #GtRBPackageChange,
	#instVars : [
		'newPackageName'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Changes'
}

{ #category : #'instance creation' }
GtRBRenamePackageChange class >> from: oldName to: newName [
	^ (self packageName: oldName)
		newPackageName: newName;
		yourself
]

{ #category : #converting }
GtRBRenamePackageChange >> asUndoOperation [
	^ self class from: newPackageName to: packageName
]

{ #category : #printing }
GtRBRenamePackageChange >> changeString [
	^ 'Rename package ' , packageName , ' to ' , newPackageName
]

{ #category : #accessing }
GtRBRenamePackageChange >> gtChangeIcon [
	^ Smalltalk ui icons iconNamed: #changeUpdate
]

{ #category : #accessing }
GtRBRenamePackageChange >> newPackageName [
	^ newPackageName
]

{ #category : #accessing }
GtRBRenamePackageChange >> newPackageName: aString [
	newPackageName := aString
]

{ #category : #private }
GtRBRenamePackageChange >> primitiveExecute [
	| package |
	package := self packageOrganizer packageNamed: packageName asSymbol.
	package renameTo: newPackageName asSymbol
]
