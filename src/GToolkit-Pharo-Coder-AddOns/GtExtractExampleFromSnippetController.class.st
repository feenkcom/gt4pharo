Class {
	#name : #GtExtractExampleFromSnippetController,
	#superclass : #GtExtractMethodFromSnippetController,
	#instVars : [
		'receiverRenamer',
		'exampleClass',
		'completionStrategy'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #accessing }
GtExtractExampleFromSnippetController >> cancelRenaming [
	self uninstallReceiverRenamer.
	super cancelRenaming
]

{ #category : #accessing }
GtExtractExampleFromSnippetController >> completionStrategy [
	^ completionStrategy
		ifNil: [ | classes |
			classes := GtPrefixTree new.
			(Pragma allNamed: 'gtExample')
				do: [ :each | 
					| cls |
					cls := each method methodClass.
					(cls isInstanceSide and: [ (classes includes: cls name) not ])
						ifTrue: [ classes add: cls name ] ].
			classes addAll: Smalltalk classNames.
			completionStrategy := GtWeightedStringsCompletionStrategy new
					completions: classes ]
]

{ #category : #accessing }
GtExtractExampleFromSnippetController >> initialize [
	super initialize.
	exampleClass := #Object.
	receiver := exampleClass asString , ' new'
]

{ #category : #accessing }
GtExtractExampleFromSnippetController >> installReceiverSelector [
	| send |
	self uninstallReceiverRenamer.
	send := self findExtractedSend.
	send ifNil: [ ^ self ].
	receiverRenamer := GtRenameSelectorAction
			variable: send parent receiver receiver
			textualCoderViewModel: sourceCoderViewModel.
	receiverRenamer completionStrategy: self completionStrategy.
	receiverRenamer newSelector: self newExtractedSelector.
	receiverRenamer selectAll: true.
	receiverRenamer
		when: GtRenameActionAnnouncement
		do: [ :ann | 
			ann eventType = #textUpdated
				ifTrue: [ receiverRenamer isValid
						ifTrue: [ self updateReceiver: receiverRenamer newVariableName ] ].
			ann eventType = #cancel ifTrue: [ self cancelRefactoring ] ].
	receiverRenamer install
]

{ #category : #accessing }
GtExtractExampleFromSnippetController >> isReceiver: aNode [
	^ aNode isMessageSend
		and: [ aNode selector = #new
				and: [ aNode receiver isVariable
						and: [ {'Object'.
								exampleClass} includes: aNode receiver name value ] ] ]
]

{ #category : #accessing }
GtExtractExampleFromSnippetController >> refactoring [
	| refactoring |
	refactoring := GtExtractExampleFromSnippetRefactoring
			extract: self extractionInterval
			from: originalSource.
	refactoring
		setOption: #selfArgumentName toUse: [ :ref | self selfArgumentName ];
		setOption: #selectVariableToMoveTo toUse: [ :ref :cls :sel | receiver ];
		setOption: #variableTypesForReceiver
			toUse: [ :ref :block | {ref model classNamed: exampleClass} ];
		setOption: #variableTypes
			toUse: [ :ref :types :selected | {ref model classNamed: exampleClass} ].
	^ refactoring
]

{ #category : #accessing }
GtExtractExampleFromSnippetController >> uninstallReceiverRenamer [
	(receiverRenamer notNil and: [ receiverRenamer isInstalled ])
		ifTrue: [ receiverRenamer uninstall ]
]

{ #category : #accessing }
GtExtractExampleFromSnippetController >> updateReceiver: aString [
	exampleClass := aString asSymbol.
	self updateReceiverTo: exampleClass , ' new'.
	self addRefactoringPreview
]
