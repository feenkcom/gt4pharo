Class {
	#name : #GtRenamePackageInBaselineController,
	#superclass : #GtRenameVariableController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #accessing }
GtRenamePackageInBaselineController >> allRenameIntervals [
	| intervals |
	intervals := OrderedCollection new.
	intervals
		add: (self originalNode startPosition + 1 to: self originalNode stopPosition - 1).
	self originalNode topParent
		withAllNodesDo: [ :each | 
			(each ~~ self originalNode and: [ each = self originalNode ])
				ifTrue: [ intervals add: (each startPosition + 1 to: each stopPosition - 1) ] ].
	^ intervals
]

{ #category : #accessing }
GtRenamePackageInBaselineController >> originalName [
	^ self originalNode literalValue
]

{ #category : #accessing }
GtRenamePackageInBaselineController >> originalSourcePosition [
	| interval |
	interval := self originalNode sourceInterval.
	^ interval first + 1 to: interval last - 1
]

{ #category : #accessing }
GtRenamePackageInBaselineController >> refactoringName [
	^ 'Rename package'
]

{ #category : #accessing }
GtRenamePackageInBaselineController >> rename: anOldName to: aNewName [
	| aModel |
	aModel := self createModel.
	^ (GtRBRenamePackageRefactoring from: anOldName to: aNewName)
		model: aModel;
		yourself
]

{ #category : #accessing }
GtRenamePackageInBaselineController >> renamePosition [
	^ super renamePosition + 1
]
