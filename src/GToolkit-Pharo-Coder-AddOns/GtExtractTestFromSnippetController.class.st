Class {
	#name : #GtExtractTestFromSnippetController,
	#superclass : #GtExtractExampleFromSnippetController,
	#category : 'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #accessing }
GtExtractTestFromSnippetController >> completionStrategy [
	^ completionStrategy
		ifNil: [ | classes |
			classes := GtPrefixTree new.
			Smalltalk
				at: #TestCase
				ifPresent: [ :cls | cls allSubclassesDo: [ :each | classes add: each name ] ].
			completionStrategy := GtStringsCompletionStrategy new completions: classes ]
]

{ #category : #accessing }
GtExtractTestFromSnippetController >> findExtractedSend [
	self shouldCreateClass ifFalse: [ ^ super findExtractedSend ].
	[ self sourceAst
		withAllNodesOfType: GtPharoMessageNode
		do: [ :each | 
			(each selector = #run:
				and: [ each arguments first isLiteral
						and: [ each arguments first isSymbol
								and: [ each arguments first literalValue = self extractedSelector
										and: [ self isReceiver: each parent receiver ] ] ] ])
				ifTrue: [ ^ each ] ] ] on: SmaCCParserError do: [ :ex | ^ nil ].
	^ nil
]

{ #category : #accessing }
GtExtractTestFromSnippetController >> installRenamer [
	| message |
	self shouldCreateClass ifFalse: [ ^ super installRenamer ].
	self addRefactoringPreview.

	message := self findExtractedSend.
	message isNil ifTrue: [ ^ self cancelRefactoring ].

	sourceCoderViewModel moveCursorTo: 0.

	renameAction := GtRenameSelectorAction
			selector: message arguments first
			textualCoderViewModel: sourceCoderViewModel.
	(self potentialReceivers size > 1 and: [ self showReceiverType ])
		ifTrue: [ renameAction focusedIndex: 0 ].
	renameAction newSelector: self newExtractedSelector.
	renameAction selectAll: true.
	renameAction
		when: GtRenameActionAnnouncement
		do: [ :ann | 
			ann eventType = #textUpdated
				ifTrue: [ renameAction isValid ifTrue: [ self updateSelector: renameAction newSelector ] ].
			ann eventType = #cancel ifTrue: [ self cancelRefactoring ] ]
		for: self.
	renameAction install
]

{ #category : #accessing }
GtExtractTestFromSnippetController >> isReceiver: aNode [
	self shouldCreateClass ifFalse: [ ^ super isReceiver: aNode ].
	^ (aNode isKindOf: GtPharoVariableNode)
		and: [ {'Object'.
				exampleClass} includes: aNode name value ]
]

{ #category : #accessing }
GtExtractTestFromSnippetController >> receiverInSend: send [
	self shouldCreateClass ifFalse: [ ^ super receiverInSend: send ].
	^ send parent receiver
]

{ #category : #accessing }
GtExtractTestFromSnippetController >> refactoringClass [
	^ GtExtractTestFromSnippetRefactoring
]

{ #category : #accessing }
GtExtractTestFromSnippetController >> refactoringClassForExistingClass [
	^ GtExtractTestFromSnippetToVariableRefactoring
]
