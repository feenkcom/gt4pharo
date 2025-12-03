Class {
	#name : #GtRenameVariableController,
	#superclass : #GtRenameController,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #accessing }
GtRenameVariableController >> addRefactoringPreview [
	super addRefactoringPreview.
	self styleRenamedVariable
]

{ #category : #accessing }
GtRenameVariableController >> allRenameIntervals [
	| intervals |
	intervals := OrderedCollection new.
	intervals add: self originalNode name sourceInterval.
	self originalNode topParent
		withAllNodesDo: [ :each | 
			(each ~~ self originalNode and: [ each = self originalNode ])
				ifTrue: [ intervals add: each name sourceInterval ] ].
	^ intervals
]

{ #category : #executing }
GtRenameVariableController >> installRenamer [
	newName := self originalName.
	renameInterval := self originalSourcePosition.

	self installRenameAction
]

{ #category : #accessing }
GtRenameVariableController >> originalName [
	^ self originalNode source
]

{ #category : #executing }
GtRenameVariableController >> originalSourcePosition [
	^ self originalNode name sourceInterval
]

{ #category : #accessing }
GtRenameVariableController >> refactoring [
	self originalName = self newName
		ifTrue: [ ^ nil ].
	^ self rename: self originalName to: self newName
]

{ #category : #accessing }
GtRenameVariableController >> rename: oldName to: newName [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtRenameVariableController >> styleRenamedVariable [
	| interval |
	interval := self currentRenameInterval.
	(self sourceText from: interval first to: interval last)
		attributes: {BlTextForegroundAttribute paint: Color gray}
]
