Class {
	#name : #GtExtractMethodController,
	#superclass : #GtAbstractExtractMethodController,
	#instVars : [
		'renameIndex'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #private }
GtExtractMethodController >> installRenamer [
	^ self installRenamerAt: 1
]

{ #category : #private }
GtExtractMethodController >> installRenamerAt: anInteger [
	| message interval |
	self addRefactoringPreview.
	self addReorderParametersAttributes.
			
	renameIndex := anInteger.
	anInteger isNil
		ifTrue: [ ^ self ].
	
	message := self findExtractedSend.
	message isNil
		ifTrue: [ ^ self cancelRefactoring ].
	
	interval := (message selectorParts at: anInteger) sourceInterval.
	
	sourceCoderViewModel moveCursorTo: ((interval first - 1) max: 0).
	
	renameAction := GtCoderViewModelRenameAction
		locations: { interval }
		textualCoderViewModel: sourceCoderViewModel.
	
	renameAction selectAll: true.

	renameAction
		when: GtRenameActionAnnouncement
		do: [ :ann | 
			ann eventType = #textUpdated
				ifTrue: [ self updateSelector: renameAction newName at: anInteger ].
			ann eventType = #accept
				ifTrue: [ self
						installRenamerAt:
							(anInteger < extractedSelectorKeywords size
								ifTrue: [ anInteger + 1 ]
								ifFalse: [ nil ]) ].
			ann eventType = #cancel
				ifTrue: [ self cancelRefactoring ] ].
	renameAction install
]

{ #category : #private }
GtExtractMethodController >> updateRenamer [
	renameIndex notNil ifTrue: [ self installRenamerAt: renameIndex ]
]
