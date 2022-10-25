Class {
	#name : #GtRenameMethodController,
	#superclass : #GtRenameController,
	#instVars : [
		'selector',
		'someImplementor',
		'newSelectorParts'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #executing }
GtRenameMethodController >> installRenamer [
	| message |
	message := self originalNode.
	selector := message selector.
	self someImplementor isNil ifTrue: [ ^ self ].

	newSelectorParts := selector keywords.

	renameAction := GtRenameSelectorAction
			message: message
			textualCoderViewModel: sourceCoderViewModel.
	renameAction newSelector: message selector.
	renameAction selectAll: true.
	renameAction
		when: GtRenameActionAnnouncement
		do: [ :ann | 
			ann eventType = #textUpdated ifTrue: [ self updateSelector ].
			ann eventType = #cancel ifTrue: [ self cancelRefactoring ] ].
	renameAction install
]

{ #category : #accessing }
GtRenameMethodController >> newName [
	^ self newSelectorName
]

{ #category : #private }
GtRenameMethodController >> newSelectorName [
	^ (String
		streamContents: [ :stream | newSelectorParts do: [ :each | stream nextPutAll: each ] ])
		asSymbol
]

{ #category : #accessing }
GtRenameMethodController >> originalName [
	^ selector
]

{ #category : #private }
GtRenameMethodController >> refactoring [
	| implementor newSelector model refactoring isCoderMethodBeingRenamed |
	implementor := self someImplementor.
	implementor isNil ifTrue: [ ^ nil ].
	newSelector := self newSelectorName.
	newSelector = selector ifTrue: [ ^ nil ].
	model := self createModel.
	isCoderMethodBeingRenamed := sourceCoderViewModel coderModel selector
			= selector.
	refactoring := (isCoderMethodBeingRenamed
			ifTrue: [ GtCoderRenameMethodRefactoring ]
			ifFalse: [ RBRenameMethodRefactoring ])
			model: model
			renameMethod: selector
			in: (model classFor: implementor)
			to: newSelector
			permutation: (1 to: selector numArgs).
	isCoderMethodBeingRenamed
		ifTrue: [ refactoring methodCoder: sourceCoderViewModel coderModel ].
	^ refactoring
]

{ #category : #accessing }
GtRenameMethodController >> refactoringName [
	^ 'Rename method'
]

{ #category : #accessing }
GtRenameMethodController >> renamePosition [
	^ self originalNode selectorParts last stopPosition
]

{ #category : #private }
GtRenameMethodController >> someImplementor [
	^ someImplementor
		ifNil: [ (SystemNavigation default allImplementorsOf: selector)
				ifEmpty: [ nil ]
				ifNotEmpty: [ :impls | someImplementor := impls anyOne methodClass ] ]
]

{ #category : #executing }
GtRenameMethodController >> updateSelector [
	renameAction isValid
		ifTrue: [ newSelectorParts := renameAction newSelector asSymbol keywords.
			selector = renameAction newSelector
				ifTrue: [ self removeRefactoringAttribute ]
				ifFalse: [ self addRefactoringPreview ] ]
]
