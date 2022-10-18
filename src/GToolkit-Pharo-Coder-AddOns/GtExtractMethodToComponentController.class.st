Class {
	#name : #GtExtractMethodToComponentController,
	#superclass : #GtAbstractExtractMethodController,
	#instVars : [
		'receiver',
		'receiverClassName',
		'newSelector'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #accessing }
GtExtractMethodToComponentController >> initialize [
	super initialize.
	receiver := 'self'
]

{ #category : #accessing }
GtExtractMethodToComponentController >> installRenamer [
	| message |
	self addRefactoringPreview.
	self addReorderParametersAttributes.

	message := self findExtractedSend.
	message isNil ifTrue: [ ^ self cancelRefactoring ].

	sourceCoderViewModel moveCursorTo: 0.

	renameAction := GtRenameSelectorAction
			message: message
			textualCoderViewModel: sourceCoderViewModel.
	renameAction newSelector: self newExtractedSelector.
	renameAction
		when: GtRenameActionAnnouncement
		do: [ :ann | 
			ann eventType = #textUpdated
				ifTrue: [ renameAction isValid ifTrue: [ self updateSelector: renameAction newSelector ] ].
			ann eventType = #cancel ifTrue: [ self cancelRefactoring ] ].
	renameAction install
]

{ #category : #accessing }
GtExtractMethodToComponentController >> newExtractedSelector [
	^ newSelector ifNil: [ super newExtractedSelector ]
]

{ #category : #accessing }
GtExtractMethodToComponentController >> refactoring [
	| refactoring model |
	receiver = 'self' ifTrue: [ ^ super refactoring ].
	model := self createModel.
	refactoring := GtExtractMethodToComponentRefactoring
			model: model
			extract: self extractionInterval
			from: methodSelector
			in: (model classFor: sourceCoderViewModel behavior).
	refactoring
		setOption: #selfArgumentName
			toUse: [ :ref | 
				| name |
				name := sourceCoderViewModel behavior name asString
						copyReplaceAll: ' class'
						with: 'Class'.
				(name first isVowel ifTrue: [ 'an' ] ifFalse: [ 'a' ]) , name ];
		setOption: #selectVariableToMoveTo toUse: [ :ref :cls :sel | receiver ];
		setOption: #variableTypesForReceiver
			toUse: [ :ref | {ref model classNamed: (receiverClassName ifNil: [ 'Object' ])} ];
		setOption: #variableTypes
			toUse: [ :ref :types :selected | {ref model classNamed: (receiverClassName ifNil: [ 'Object' ])} ].
	^ refactoring
]

{ #category : #accessing }
GtExtractMethodToComponentController >> updateRenamer [
	self installRenamer
]

{ #category : #accessing }
GtExtractMethodToComponentController >> updateSelector: aSymbol [
	newSelector := aSymbol.
	self addRefactoringPreview
]
