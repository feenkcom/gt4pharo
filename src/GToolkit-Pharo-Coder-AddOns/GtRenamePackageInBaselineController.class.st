Class {
	#name : #GtRenamePackageInBaselineController,
	#superclass : #GtRenameVariableController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #accessing }
GtRenamePackageInBaselineController >> allRenameIntervals [
	| intervals |
	intervals := OrderedCollection new.
	intervals add: (self intervalForNode: self originalNode).
	self originalNode topParent
		withAllNodesDo: [ :each | 
			(each ~~ self originalNode
				and: [ each isLiteral and: [ each literalValue = self originalNode literalValue ] ])
				ifTrue: [ intervals add: (self intervalForNode: each) ] ].
	^ intervals
]

{ #category : #accessing }
GtRenamePackageInBaselineController >> installValidation [
	renameAction forText
]

{ #category : #accessing }
GtRenamePackageInBaselineController >> intervalForNode: aNode [
	| source hasQuotes |
	source := aNode source.
	hasQuotes := source last = $'.
	^ aNode startPosition
		+ (hasQuotes ifTrue: [ source indexOf: $' ] ifFalse: [ 1 ])
		to: aNode stopPosition - (hasQuotes ifTrue: [ 1 ] ifFalse: [ 0 ])
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
