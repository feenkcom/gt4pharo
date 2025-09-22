Class {
	#name : #GtRBRenamePackageTagChange,
	#superclass : #GtRBPackageChange,
	#instVars : [
		'newName',
		'oldName'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Changes'
}

{ #category : #'instance creation' }
GtRBRenamePackageTagChange class >> packageName: packageName from: oldName to: newName [
	^ (self packageName: packageName)
		oldName: oldName;
		newName: newName;
		yourself
]

{ #category : #converting }
GtRBRenamePackageTagChange >> asUndoOperation [
	^ self class packageName: packageName from: newName to: oldName
]

{ #category : #printing }
GtRBRenamePackageTagChange >> changeString [
	^ 'Rename package tag in ' , packageName , ' from ' , oldName
		, ' to ' , newName
]

{ #category : #accessing }
GtRBRenamePackageTagChange >> newName [
	^ newName
]

{ #category : #accessing }
GtRBRenamePackageTagChange >> newName: aString [
	newName := aString
]

{ #category : #accessing }
GtRBRenamePackageTagChange >> oldName [
	^ oldName
]

{ #category : #accessing }
GtRBRenamePackageTagChange >> oldName: aString [
	oldName := aString
]

{ #category : #private }
GtRBRenamePackageTagChange >> primitiveExecute [
	| package |
	package := self packageOrganizer packageNamed: packageName asSymbol.
	(package tagNamed: oldName asSymbol) renameTo: newName asSymbol
]
