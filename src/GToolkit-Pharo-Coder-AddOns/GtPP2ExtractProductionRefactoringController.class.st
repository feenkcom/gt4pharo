Class {
	#name : #GtPP2ExtractProductionRefactoringController,
	#superclass : #GtExtractMethodToComponentController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #accessing }
GtPP2ExtractProductionRefactoringController >> addReorderParametersAttributes [
]

{ #category : #accessing }
GtPP2ExtractProductionRefactoringController >> findExtractedSend [
	^ self findExtractedVariable
]

{ #category : #accessing }
GtPP2ExtractProductionRefactoringController >> findExtractedVariable [
	[ self sourceAst
		withAllNodesOfType: GtPharoVariableNode
		do: [ :each | each name source = self extractedSelector asString ifTrue: [ ^ each ] ] ]
		on: SmaCCParserError
		do: [ :ex | ^ nil ].
	^ nil
]

{ #category : #accessing }
GtPP2ExtractProductionRefactoringController >> installReceiverSelector [
]

{ #category : #accessing }
GtPP2ExtractProductionRefactoringController >> installRenamer [
	| variable |
	self addRefactoringPreview.

	variable := self findExtractedSend.
	variable ifNil: [ ^ self cancelRefactoring ].

	sourceCoderViewModel moveCursorTo: 0.

	renameAction := GtPP2RenameVariableAction
			locations: {variable sourceInterval}
			textualCoderViewModel: sourceCoderViewModel.
	renameAction selectAll: true.
	renameAction forVariableOrUnaryMessage.
	renameAction
		when: GtRenameActionAnnouncement
		do: [ :ann | 
			ann eventType = #textUpdated
				ifTrue: [ renameAction isValid ifTrue: [ self updateSelector: renameAction newName ] ].
			ann eventType = #cancel ifTrue: [ self cancelRefactoring ] ].
	renameAction install
]

{ #category : #accessing }
GtPP2ExtractProductionRefactoringController >> refactoring [
	| model |
	model := self createModel.
	^ GtPP2ExtractProductionRefactoring
		model: model
		extract: self extractionInterval
		from: sourceCoderViewModel selector
		in: (model classFor: sourceCoderViewModel behavior)
]
