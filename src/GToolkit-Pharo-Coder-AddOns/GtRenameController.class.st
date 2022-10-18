Class {
	#name : #GtRenameController,
	#superclass : #GtPharoSourceCoderRefactoringController,
	#instVars : [
		'handlers',
		'renameAction',
		'node',
		'newName',
		'renameInterval',
		'completionAction'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #private }
GtRenameController >> addRefactoringChangesPreview [
	| aRefactoring aRenamePosition |
	self removeRefactoringAttribute.

	aRefactoring := self refactoring.
	aRefactoring
		ifNil: [ ^ self cancelRefactoring ].

	aRenamePosition := self renamePosition.

	self
		addRefactoringChangesPreview: aRefactoring
		at: aRenamePosition
		whenComplete: [
			self removeRefactoringAttribute.
			self completionAction value.
			self allowSave ]
]

{ #category : #executing }
GtRenameController >> allRenameIntervals [
	^ {renameInterval}
]

{ #category : #executing }
GtRenameController >> cancelRefactoring [
	self removeRefactoringAttribute.
	self restoreText.
	self allowSave
]

{ #category : #accessing }
GtRenameController >> completionAction [
	^ completionAction ifNil: [ [  ] ]
]

{ #category : #accessing }
GtRenameController >> completionAction: aBlock [
	completionAction := aBlock
]

{ #category : #executing }
GtRenameController >> createModel [
	| model |
	model := RBClassModelFactory rbNamespace
		onEnvironment: RBBrowserEnvironment new.
	model name: self refactoringName.
	sourceCoderViewModel coderModel isForMethod
		ifTrue: [ ((model classFor: sourceCoderViewModel behavior) sourceCodeFor: sourceCoderViewModel selector)
				~= originalSource asString
				ifTrue: [ (model classFor: sourceCoderViewModel behavior)
						compile: originalSource asString
						classified: sourceCoderViewModel protocol ] ].
	^ model
]

{ #category : #private }
GtRenameController >> currentRenameInterval [
	| end offsetCount start |
	(renameAction isNil or: [ renameAction isInstalled ])
		ifTrue: [ ^ renameInterval ].
	start := self allRenameIntervals first first.
	offsetCount := self allRenameIntervals
			inject: 0
			into: [ :sum :each | sum + (each first <= start ifTrue: [ 1 ] ifFalse: [ 0 ]) ].
	end := renameInterval last
			+ ((self newName size - self originalName size) * offsetCount).
	^end - self newName size + 1 to: end
]

{ #category : #accessing }
GtRenameController >> cursorPositionDo: aBlock [
	sourceCoderViewModel cursors
		do: [ :eachCursor | ^ aBlock value: (eachCursor position + 1 min: self sourceText size) ]
]

{ #category : #executing }
GtRenameController >> installRenameAction [
	renameAction := self renameAction.

	renameAction selectAll: true.

	self preventSave.

	renameAction
		when: GtRenameActionAnnouncement
		do: [ :ann | 
			(#(#textUpdated #accept) includes: ann eventType)
				ifTrue: [ self updateName: renameAction newName ].
			(#(#tab #shiftTab) includes: ann eventType)
				ifTrue: [ self tab: ann eventType = #tab ].
			ann eventType = #cancel ifTrue: [ self cancelRefactoring ] ].

	self installValidation.
	renameAction install
]

{ #category : #executing }
GtRenameController >> installRenamer [
	self subclassResponsibility
]

{ #category : #accessing }
GtRenameController >> installValidation [
	renameAction forVariableOrUnaryMessage
]

{ #category : #accessing }
GtRenameController >> newName [
	^ newName
]

{ #category : #accessing }
GtRenameController >> originalName [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtRenameController >> originalNode [
	<return: #GtPharoProgramNode>

	^ node
]

{ #category : #accessing }
GtRenameController >> originalNode: aGtPharoProgramNode [
	node := aGtPharoProgramNode
]

{ #category : #executing }
GtRenameController >> renameAction [
	^ GtCoderViewModelRenameAction
		locations: self allRenameIntervals
		textualCoderViewModel: sourceCoderViewModel
]

{ #category : #private }
GtRenameController >> renamePosition [
	^ self currentRenameInterval last
]

{ #category : #executing }
GtRenameController >> safelyExecute [
	self installRenamer
]

{ #category : #private }
GtRenameController >> tab: forward [
]

{ #category : #private }
GtRenameController >> updateName: aString [
	newName := aString.
	self addRefactoringChangesPreview
]
