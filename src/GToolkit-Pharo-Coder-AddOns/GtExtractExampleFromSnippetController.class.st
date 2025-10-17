Class {
	#name : #GtExtractExampleFromSnippetController,
	#superclass : #GtExtractMethodFromSnippetController,
	#instVars : [
		'receiverRenamer',
		'exampleClass',
		'completionStrategy',
		'packageForm',
		'packageElement',
		'shouldCreateClass'
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
			(Pragma allNamed: #gtExample)
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
GtExtractExampleFromSnippetController >> createRefactoringChangesAttributeFor: aRefactoring onCompletion: aBlock [
	^ GtRefactoringWithInputWidgetChangesAttribute new
		refactoring: (self isClassDefined ifTrue: [ aRefactoring ] ifFalse: [ nil ]);
		refactoringsViewModelDo: [ :refactoringsViewModel | 
			refactoringsViewModel
				refactoringTitle: 'Extract example';
				refactoringsWithConfirmation: [ self isClassDefined
						ifTrue: [ | ref |
							ref := self refactoring.
							self setPreviewOptionsOn: ref.
							{ref} ]
						ifFalse: [ #() ] ] ];
		focusAction: [ :container :button :refactoringsViewModel | 
			self isClassDefined
				ifTrue: [ refactoringsViewModel isPreviewButtonFocused: true ]
				ifFalse: [ refactoringsViewModel isPreviewButtonFocused: false.
					container
						childWithId: #package
						ifFound: [ :el | 
							el
								enqueueTask: [ el childWithId: #label ifFound: [ :label | label requestFocus ] ] asBlTask ] ] ];
		completionAction: aBlock;
		cancelAction: [ self cancelRefactoring ];
		showWhenCreated: self previewDisplaysImmediately;
		inputElement: [ :aRefactoringsViewModel | 
			self useExistingClass
				ifFalse: [ | editorElement viewModel |
					viewModel := packageForm asGtMagritteViewModel.
					viewModel focusFirstInputField.
					editorElement := viewModel asElement.
					editorElement padding: (BlInsets all: 10).
					editorElement ]
				ifTrue: [ nil ] ]
]

{ #category : #accessing }
GtExtractExampleFromSnippetController >> initialize [
	super initialize.
	exampleClass := #Object.
	receiver := exampleClass asString , ' new'.
	packageForm := GtPackageTagForm new
			onAccept: [ :model :button | 
				BlTaskAction enqueueElement: button action: [
					| anEvent |
					anEvent := GtRefactoringsViewModelWish new.
					button fireEvent: anEvent.
					anEvent refactoringsViewModelDo: [ :aRefactoringsViewModel | 
						aRefactoringsViewModel inputReady ] ] ]
]

{ #category : #accessing }
GtExtractExampleFromSnippetController >> installReceiverSelector [
	| send |
	self shouldCreateClass ifFalse: [ ^ super installReceiverSelector ].
	self uninstallReceiverRenamer.
	send := self findExtractedSend.
	send ifNil: [ ^ self ].
	receiverRenamer := GtRenameSelectorAction
			variable: (self receiverInSend: send)
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
			ann eventType = #cancel ifTrue: [ self cancelRefactoring ] ]
		for: self.
	receiverRenamer install
]

{ #category : #accessing }
GtExtractExampleFromSnippetController >> isClassDefined [
	^ self useExistingClass or: [ packageForm packageAndTagName isEmpty not ]
]

{ #category : #accessing }
GtExtractExampleFromSnippetController >> isReceiver: aNode [
	self shouldCreateClass ifFalse: [ ^ super isReceiver: aNode ].
	^ aNode isMessageSend
		and: [ aNode selector = #new
				and: [ aNode receiver isVariable
						and: [ {'Object'.
								exampleClass} includes: aNode receiver name value ] ] ]
]

{ #category : #accessing }
GtExtractExampleFromSnippetController >> potentialReceivers [
	| names |
	names := super potentialReceivers.
	self extractedAst pattern variables
		ifNotEmpty: [ :vars | 
			vars size = 1
				ifTrue: [ names remove: vars first source ifAbsent: [  ].
					names addFirst: vars first source ] ].
	^ names
]

{ #category : #accessing }
GtExtractExampleFromSnippetController >> receiverInSend: send [
	^ send parent receiver receiver
]

{ #category : #accessing }
GtExtractExampleFromSnippetController >> refactoring [
	| refactoring |
	self shouldCreateClass
		ifFalse: [ refactoring := self refactoringClassForExistingClass
					extract: self extractionInterval
					from: originalSource.
			refactoring
				setOption: #selfArgumentName toUse: [ :ref | self selfArgumentName ];
				setOption: #selectVariableToMoveTo
					toUse: [ :ref :cls :sel | self getReceiverVariableFor: cls selector: sel ];
				setOption: #variableTypesForReceiver
					toUse: [ :ref :block | 
						| classes |
						classes := (self getTypeForReceiverIn: ref model) ifNil: block.
						self getTypeForReceiverFor: ref from: classes ];
				setOption: #variableTypes
					toUse: [ :ref :types :selected | self getTypeForReceiverFor: ref from: types ].
			^ refactoring ].
	refactoring := self refactoringClass
			extract: self extractionInterval
			from: originalSource
			into: exampleClass
			category: packageForm category.
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
GtExtractExampleFromSnippetController >> refactoringClass [
	^ GtExtractExampleFromSnippetToClassRefactoring
]

{ #category : #accessing }
GtExtractExampleFromSnippetController >> refactoringClassForExistingClass [
	^ GtExtractExampleFromSnippetToVariableRefactoring
]

{ #category : #accessing }
GtExtractExampleFromSnippetController >> shouldCreateClass [
	| refactoring |
	^ shouldCreateClass
		ifNil: [ shouldCreateClass := true.
			refactoring := GtExtractMethodFromSnippetRefactoring
					extract: self extractionInterval
					from: originalSource.
			refactoring
				setOption: #selfArgumentName toUse: [ :ref | self selfArgumentName ];
				setOption: #selectVariableToMoveTo
					toUse: [ :ref :cls :sel | 
						(cls methodFor: sel) ast arguments
							ifNotEmpty: [ :args | 
								args size = 1
									ifTrue: [ shouldCreateClass := false.
										receiver := nil.
										receiverClassName := nil ] ].
						ref refactoringError: 'cancel' ];
				setOption: #variableTypesForReceiver
					toUse: [ :ref :block | 
						| classes |
						classes := (self getTypeForReceiverIn: ref model) ifNil: block.
						self getTypeForReceiverFor: ref from: classes ];
				setOption: #variableTypes
					toUse: [ :ref :types :selected | self getTypeForReceiverFor: ref from: types ].
			[ refactoring primitiveExecute ]
				on: RBRefactoringError
				do: [ :ex | ex return ].
			shouldCreateClass ]
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

{ #category : #accessing }
GtExtractExampleFromSnippetController >> useExistingClass [
	^ Smalltalk includesKey: exampleClass asSymbol
]
