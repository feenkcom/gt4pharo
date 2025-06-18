Class {
	#name : #GtRBPackageChange,
	#superclass : #RBRefactoryChange,
	#instVars : [
		'packageName'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Changes'
}

{ #category : #'instance creation' }
GtRBPackageChange class >> packageName: aString [
	^ self new
		packageName: aString;
		yourself
]

{ #category : #converting }
GtRBPackageChange >> asUndoOperation [
	^self subclassResponsibility
]

{ #category : #private }
GtRBPackageChange >> executeNotifying: aBlock [
	| undo |
	undo := self asUndoOperation.
	undo name: self name.
	self primitiveExecute.
	aBlock value.
	^ undo
]

{ #category : #accessing }
GtRBPackageChange >> package [
	^ self packageOrganizer packageNamed: packageName ifAbsent: [  ]
]

{ #category : #accessing }
GtRBPackageChange >> packageName [
	^ packageName
]

{ #category : #accessing }
GtRBPackageChange >> packageName: aString [
	packageName := aString
]

{ #category : #private }
GtRBPackageChange >> primitiveExecute [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtRBPackageChange >> renameChangesForClass: oldClassName to: newClassName [
]

{ #category : #accessing }
GtRBPackageChange >> tag [
	^ nil
]
