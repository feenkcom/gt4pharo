"
nil
"
Class {
	#name : #GtExtractMethodToComponentController,
	#superclass : #GtAbstractExtractMethodController,
	#instVars : [
		'receiver',
		'receiverClassName',
		'newSelector',
		'receiverAttribute',
		'extractedMethod',
		'potentialReceivers',
		'potentialTypes'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #accessing }
GtExtractMethodToComponentController >> defaultReceiverClassName [
	receiver = 'self' ifTrue: [ ^ sourceCoderViewModel behavior name ].
	(sourceCoderViewModel behavior bindingOf: receiver asSymbol) value
		ifNotNil: [ :value | ^ value class name ].
	potentialTypes size = 1 ifTrue: [ ^ (potentialTypes first: 1) first asSymbol ].
	^ #Object
]

{ #category : #accessing }
GtExtractMethodToComponentController >> extractedAst [
	^ GtPharoParser parse: extractedMethod
]

{ #category : #accessing }
GtExtractMethodToComponentController >> finishRefactoring [
	super finishRefactoring.
	sourceCoderViewModel discardChanges
]

{ #category : #accessing }
GtExtractMethodToComponentController >> initialize [
	super initialize.
	receiver := 'self'
]

{ #category : #'private - attributes' }
GtExtractMethodToComponentController >> installReceiverSelector [
	| attribute send |
	self removeReceiverSelector.
	send := self findExtractedSend.
	send ifNil: [ ^ self ].
	attribute := GtMessageReceiverAttribute new
			refactoringController: self;
			receivers: self potentialReceivers.
	receiverAttribute := self sourceCoderViewModel
			addTextAttribute: attribute
			from: send parent receiver startPosition
			to: send parent receiver stopPosition
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
	renameAction selectAll: true.
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
GtExtractMethodToComponentController >> potentialReceivers [
	| names extractedAst variablesRead variablesWritten allInstVarNames allClassVarNames temps extractedSend |
	potentialReceivers ifNotNil: [ ^ potentialReceivers ].
	
	allInstVarNames := sourceCoderViewModel behavior allInstVarNames.
	allClassVarNames := sourceCoderViewModel behavior allClassVarNames.
	extractedAst := self extractedAst.
	extractedSend := self findExtractedSend.

	"Include self and arguments to the extracted method first as they are the most likely"
	names := OrderedCollection with: 'self'.
	names
		addAll: (extractedAst pattern variables collect: [ :each | each source ])
				asSortedCollection.

	"Include instance or class variables or globals used in the extracted method next"
	variablesRead := self variablesReadIn: extractedAst.
	variablesWritten := self variablesWrittenIn: extractedAst.
	variablesRead := variablesRead asSortedCollection
			reject: [ :each | (names includes: each) or: [ variablesWritten includes: each ] ].
	variablesRead
		do: [ :each | (allInstVarNames includes: each) ifTrue: [ names add: each ] ].
	variablesRead
		do: [ :each | (allClassVarNames includes: each) ifTrue: [ names add: each ] ].
	variablesRead
		do: [ :each | (Smalltalk includesKey: each asSymbol) ifTrue: [ names add: each ] ].

	"Next include variables (temps, inst/class, globals) used in the original method."
	temps := self temporariesAssignedBefore: extractedSend.
	temps := temps asSortedCollection
			reject: [ :each | (names includes: each) or: [ variablesWritten includes: each ] ].
	names addAll: temps.

	variablesRead := self variablesReadIn: extractedSend topParent.
	variablesRead := variablesRead asSortedCollection
			reject: [ :each | (names includes: each) or: [ variablesWritten includes: each ] ].
	variablesRead
		do: [ :each | (allInstVarNames includes: each) ifTrue: [ names add: each ] ].
	variablesRead
		do: [ :each | (allClassVarNames includes: each) ifTrue: [ names add: each ] ].
	variablesRead
		do: [ :each | (Smalltalk includesKey: each asSymbol) ifTrue: [ names add: each ] ].
	
	"Finally include all other instance and class variables"
	allInstVarNames
		do: [ :each | (names includes: each) ifFalse: [ names add: each ] ].
	allClassVarNames
		do: [ :each | (names includes: each) ifFalse: [ names add: each ] ].
	potentialReceivers := names.
	^ potentialReceivers
]

{ #category : #accessing }
GtExtractMethodToComponentController >> potentialTypes [
	^ potentialTypes ifNil: [ GtPrefixTree new ]
]

{ #category : #accessing }
GtExtractMethodToComponentController >> receiver [
	^ receiver
]

{ #category : #accessing }
GtExtractMethodToComponentController >> receiver: aString [
	| previous previousClass |
	previous := receiver.
	previousClass := receiverClassName.
	receiver := aString.
	receiverClassName := nil.
	self cancelRefactoring.
	[ self safelyExecute ]
		on: Error
		do: [ :ex | 
			self potentialReceivers remove: aString ifAbsent: [  ].
			receiver := previous.
			receiverClassName := previousClass.
			self safelyExecute ]
]

{ #category : #accessing }
GtExtractMethodToComponentController >> receiverClassName [
	^ receiverClassName ifNil: [ self defaultReceiverClassName ]
]

{ #category : #accessing }
GtExtractMethodToComponentController >> receiverClassName: aSymbol [
	receiverClassName := aSymbol asSymbol.
	self addRefactoringPreview
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
		setOption: #variableTypes
			toUse: [ :ref :types :selected | 
				potentialTypes := GtPrefixTree withAll: (types collect: [ :each | each name ]).
				{ref model classNamed: self receiverClassName} ].
	^ refactoring
]

{ #category : #'private - attributes' }
GtExtractMethodToComponentController >> removeReceiverSelector [
	receiverAttribute ifNil: [ ^ self ].
	self sourceCoderViewModel removeAttribute: receiverAttribute
]

{ #category : #private }
GtExtractMethodToComponentController >> setDefaultOptionsOn: aRefactoring [
	super setDefaultOptionsOn: aRefactoring.
	receiver = 'self' ifTrue: [ ^ self ].
	aRefactoring
		setOption: #useExistingMethod toUse: [ :ref :sel | false ];
		setOption: #extractAssignment toUse: [ :ref :varName | false ]
]

{ #category : #private }
GtExtractMethodToComponentController >> setPreviewOptionsOn: aRefactoring [
	super setPreviewOptionsOn: aRefactoring.
	receiver = 'self' ifTrue: [ ^ self ].
	aRefactoring
		setOption: #useExistingMethod toUse: [ :ref :sel | false ];
		setOption: #extractAssignment toUse: [ :ref :varName | false ]
]

{ #category : #testing }
GtExtractMethodToComponentController >> showReceiverType [
	receiver = 'self' ifTrue: [ ^ false ].
	^ (sourceCoderViewModel behavior bindingOf: receiver asSymbol) value
		ifNotNil: [ :value | (value isBehavior and: [ value name = receiver ]) not ]
		ifNil: [ true ]
]

{ #category : #accessing }
GtExtractMethodToComponentController >> temporariesAssignedBefore: extractedSend [
	| temps |
	temps := Set new.
	extractedSend allParents
		do: [ :each | 
			(each isKindOf: GtPharoBlockNode)
				ifTrue: [ each variables do: [ :var | temps add: var source ] ].
			(each isKindOf: GtPharoSequenceNode)
				ifTrue: [ each variables
						do: [ :var | 
							| isAssigned |
							isAssigned := false.
							each
								allNodesOfType: GtPharoAssignmentNode
								do: [ :assn | isAssigned := isAssigned or: [ assn stopPosition < extractedSend startPosition ] ].
							isAssigned ifTrue: [ temps add: var source ] ] ] ].
	^ temps
]

{ #category : #accessing }
GtExtractMethodToComponentController >> updateFromModel: aRBModel [
	extractedMethod
		ifNil: [ extractedMethod := ((aRBModel classFor: sourceCoderViewModel behavior)
					methodFor: self extractedSelector) source ].
	newSelector
		ifNotNil: [ newSelector numArgs ~= self extractedSelector numArgs
				ifTrue: [ newSelector := nil ] ].
	super updateFromModel: aRBModel
]

{ #category : #accessing }
GtExtractMethodToComponentController >> updateMethod: newSource [
	super updateMethod: newSource.
	self installReceiverSelector
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

{ #category : #accessing }
GtExtractMethodToComponentController >> variablesReadIn: extractedAst [
	| variablesRead |
	variablesRead := Set new.
	extractedAst
		withAllNodesOfType: GtPharoVariableNode
		do: [ :each | variablesRead add: each source ].
	^ variablesRead
]

{ #category : #accessing }
GtExtractMethodToComponentController >> variablesWrittenIn: extractedAst [
	| variablesWritten |
	variablesWritten := Set new.
	extractedAst
		withAllNodesOfType: GtPharoAssignmentNode
		do: [ :each | variablesWritten add: each variable source ].
	^ variablesWritten
]
