Class {
	#name : #GtExtractMethodToComponentController,
	#superclass : #GtPharoSourceCoderRefactoringController,
	#instVars : [
		'methodArguments',
		'isExisting',
		'extractedSelectorKeywords',
		'extractionInterval',
		'moveAttributes',
		'renameAction',
		'receiver',
		'receiverClassName',
		'newSelector',
		'receiverAttribute',
		'extractedMethod',
		'potentialReceivers',
		'potentialTypes'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #private }
GtExtractMethodToComponentController >> addReorderParametersAttributes [
	| message |
	self removeReorderParametersAttributes.
	message := self findExtractedSend.
	message isNil ifTrue: [ ^ self ].
	self addReorderParametersAttributesOn: message
]

{ #category : #private }
GtExtractMethodToComponentController >> addReorderParametersAttributesOn: message [
	| attribute |
	extractedSelectorKeywords size > 1 ifFalse: [ ^ self ].
	moveAttributes := OrderedCollection new.
	message values
		keysAndValuesDo:
			[ :i :each | 
			i > 1
				ifTrue:
					[ attribute := GtReorderParametersAttribute
						action: [ self swapParameterWithNext: i - 1 ]
						icon: BrGlamorousVectorIcons left.
					moveAttributes add: attribute.
					self sourceCoderViewModel
						addTextAttribute: attribute
						from: each startPosition - 1
						to: each startPosition - 1 ].
			i < message values size
				ifTrue:
					[ attribute := GtReorderParametersAttribute
						action: [ self swapParameterWithNext: i ]
						icon: BrGlamorousVectorIcons right.
					moveAttributes add: attribute.
					self sourceCoderViewModel
						addTextAttribute: attribute
						from: each stopPosition
						to: each stopPosition ] ]
]

{ #category : #executing }
GtExtractMethodToComponentController >> cancelRefactoring [
	self cancelRenaming.
	self removeAllAttributes.
	super cancelRefactoring
]

{ #category : #private }
GtExtractMethodToComponentController >> cancelRenaming [
	self isRenaming ifTrue: [ renameAction cancel ]
]

{ #category : #accessing }
GtExtractMethodToComponentController >> defaultReceiverClassName [
	(receiver sameContentAs: 'self')
		ifTrue: [ ^ sourceCoderViewModel behavior name ].
	(sourceCoderViewModel behavior bindingOf: receiver asSymbol) value
		ifNotNil: [ :value | ^ value class name ].
	potentialTypes size = 1 ifTrue: [ ^ (potentialTypes first: 1) first asSymbol ].
	^ #Object
]

{ #category : #accessing }
GtExtractMethodToComponentController >> dummySelectorForArgs: argCount [
	argCount = 0 ifTrue: [ ^ #_ ].
	^ (String
		streamContents: [ :stream | argCount timesRepeat: [ stream nextPutAll: '_:' ] ])
		asSymbol
]

{ #category : #executing }
GtExtractMethodToComponentController >> executeRefactoring [
	| refactoring |
	refactoring := self refactoring.
	self setDefaultOptionsOn: refactoring.
	refactoring primitiveExecute.
	self updateFromRefactoring: refactoring
]

{ #category : #accessing }
GtExtractMethodToComponentController >> extractedAst [
	^ GtPharoParser parse: extractedMethod
]

{ #category : #private }
GtExtractMethodToComponentController >> extractedSelector [
	^ (String
		streamContents:
			[ :stream | extractedSelectorKeywords do: [ :each | stream nextPutAll: each ] ])
		asSymbol
]

{ #category : #executing }
GtExtractMethodToComponentController >> extractionInterval [
	^ extractionInterval
		ifNil: [ | nodes |
			nodes := sourceCoderViewModel coderModel extractableNodesFrom: sourceCoderViewModel.
			nodes ifEmpty: [ ^ 1 to: 0 ].
			extractionInterval := nodes first startPosition to: nodes last stopPosition ]
]

{ #category : #private }
GtExtractMethodToComponentController >> findExtractedSend [
	[ self sourceAst
		withAllNodesOfType: GtPharoMessageNode
		do: [ :each | 
			(each selector = self extractedSelector
				and: [ ((1 to: methodArguments size)
						allSatisfy: [ :i | 
							(each arguments at: i) source = (methodArguments at: i)
								or: [ (each arguments at: i) source = 'self'
										and: [ ((methodArguments at: i)
												indexOfSubCollection: sourceCoderViewModel behavior instanceSide name)
												> 0 ] ] ]) and: [ self isReceiver: each parent receiver ] ])
				ifTrue: [ ^ each ] ] ] on: SmaCCParserError do: [ :ex | ^ nil ].
	^ nil
]

{ #category : #accessing }
GtExtractMethodToComponentController >> finishRefactoring: refactoring [
	super finishRefactoring: refactoring.
	self removeAllAttributes.
	sourceCoderViewModel discardChanges
]

{ #category : #private }
GtExtractMethodToComponentController >> getCurrentState [
	^ {receiver.
		receiverClassName}
]

{ #category : #accessing }
GtExtractMethodToComponentController >> initialize [
	super initialize.
	moveAttributes := #().
	receiver := 'self'.
	methodArguments := #().
	extractedSelectorKeywords := #()
]

{ #category : #'private - attributes' }
GtExtractMethodToComponentController >> installReceiverSelector [
	| attribute send receivers |
	self removeReceiverSelector.
	send := self findExtractedSend.
	send ifNil: [ ^ self ].
	receivers := self potentialReceivers.
	receivers size <= 1 ifTrue: [ ^ self ].
	attribute := GtMessageReceiverAttribute new
			refactoringController: self;
			receivers: receivers.
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

{ #category : #private }
GtExtractMethodToComponentController >> isReceiver: aNode [
	^ (aNode isKindOf: GtPharoVariableNode)
		and: [ aNode name value sameContentAs: self receiver ]
]

{ #category : #testing }
GtExtractMethodToComponentController >> isRenaming [
	^ renameAction notNil and: [ renameAction isInstalled ]
]

{ #category : #private }
GtExtractMethodToComponentController >> isValidForPreview [
	^ self findExtractedSend notNil
]

{ #category : #accessing }
GtExtractMethodToComponentController >> newExtractedSelector [
	^ newSelector ifNil: [ self extractedSelector ]
]

{ #category : #private }
GtExtractMethodToComponentController >> parserStartingState [
	^ GtPharoParser startingStateForMethod
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

{ #category : #private }
GtExtractMethodToComponentController >> previewPosition [
	^ self findExtractedSend stopPosition
]

{ #category : #accessing }
GtExtractMethodToComponentController >> receiver [
	^ receiver
]

{ #category : #accessing }
GtExtractMethodToComponentController >> receiver: aString [
	| state |
	state := self getCurrentState.
	self updateReceiverTo: aString.
	self cancelRefactoring.
	[ self safelyExecute ]
		on: Error
		do: [ :ex | 
			self potentialReceivers remove: aString ifAbsent: [  ].
			self setCurrentState: state.
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
	receiver = 'self'
		ifTrue: [ model := self createModel.
			^ GtExtractMethodRefactoring
				model: model
				extract: self extractionInterval
				from: sourceCoderViewModel selector
				in: (model classFor: sourceCoderViewModel behavior) ].
	model := self createModel.
	refactoring := GtExtractMethodToComponentRefactoring
			model: model
			extract: self extractionInterval
			from: sourceCoderViewModel selector
			in: (model classFor: sourceCoderViewModel behavior).
	refactoring
		setOption: #selfArgumentName toUse: [ :ref | self selfArgumentName ];
		setOption: #selectVariableToMoveTo toUse: [ :ref :cls :sel | receiver ];
		setOption: #variableTypes
			toUse: [ :ref :types :selected | 
				potentialTypes := GtPrefixTree withAll: (types collect: [ :each | each name ]).
				{ref model classNamed: self receiverClassName} ].
	^ refactoring
]

{ #category : #executing }
GtExtractMethodToComponentController >> refactoringFailed [
	self sourceCoderViewModel allowSaveDueTo: self
]

{ #category : #accessing }
GtExtractMethodToComponentController >> refactoringName [
	^ 'Extract method'
]

{ #category : #'private - attributes' }
GtExtractMethodToComponentController >> removeAllAttributes [
	self removeRenaming.
	self removeReorderParametersAttributes.
	self removeReceiverSelector
]

{ #category : #'private - attributes' }
GtExtractMethodToComponentController >> removeReceiverSelector [
	receiverAttribute ifNil: [ ^ self ].
	self sourceCoderViewModel removeCoderTextAttributes: receiverAttribute
]

{ #category : #private }
GtExtractMethodToComponentController >> removeRenaming [
	self isRenaming ifTrue: [ renameAction uninstall ]
]

{ #category : #private }
GtExtractMethodToComponentController >> removeReorderParametersAttributes [
	moveAttributes do: [ :each | self sourceCoderViewModel removeAttribute: each ]
]

{ #category : #accessing }
GtExtractMethodToComponentController >> resetNewSelectorIfNeeded [
	newSelector
		ifNotNil: [ newSelector numArgs ~= self extractedSelector numArgs
				ifTrue: [ newSelector := nil ] ]
]

{ #category : #executing }
GtExtractMethodToComponentController >> safelyExecute [
	self executeRefactoring
]

{ #category : #private }
GtExtractMethodToComponentController >> setCurrentState: anArray [
	receiver := anArray first.
	receiverClassName := anArray second
]

{ #category : #private }
GtExtractMethodToComponentController >> setDefaultOptionsOn: aRefactoring [
	isExisting := false.
	aRefactoring
		setOption: #methodName
		toUse: [ :methodName | 
			| selector |
			(methodArguments size = methodName arguments size
				and: [ methodArguments allSatisfy: [ :each | methodName arguments includes: each ] ])
				ifFalse: [ | positions |
					positions := Dictionary new.
					self ast
						withAllNodesDo: [ :each | 
							(each isVariable and: [ methodName arguments includes: each variableName ])
								ifTrue: [ positions at: each variableName ifAbsentPut: each startPosition ] ].
					methodArguments := Array
							withAll: (methodName arguments
									asSortedCollection: [ :a :b | 
										| aValue bValue |
										aValue := positions at: a ifAbsent: [ 0 ].
										bValue := positions at: b ifAbsent: [ 0 ].
										aValue < bValue or: [ aValue = bValue and: [ a < b ] ] ]) ].
			methodName arguments: methodArguments.
			selector := self
					safeMethodName: methodName
					in: (aRefactoring model classFor: sourceCoderViewModel behavior).
			selector numArgs = self extractedSelector numArgs
				ifTrue: [ selector := self extractedSelector ].
			extractedSelectorKeywords := selector keywords.
			methodName
				selector: selector;
				yourself ].
	aRefactoring
		setOption: #useExistingMethod
			toUse: [ :ref :sel | 
				receiver = 'self'
					and: [ extractedSelectorKeywords := sel keywords.
						isExisting := true ] ];
		setOption: #extractAssignment
			toUse: [ :ref :varName | 
				receiver = 'self'
					and: [ (aRefactoring model classFor: sourceCoderViewModel behavior)
							definesVariable: varName ] ]
]

{ #category : #private }
GtExtractMethodToComponentController >> setPreviewOptionsOn: aRefactoring [
	aRefactoring
		setOption: #methodName
		toUse: [ :methodName | 
			methodName selector: self newExtractedSelector.
			(methodArguments size = methodName arguments size
				and: [ methodArguments allSatisfy: [ :each | methodName arguments includes: each ] ])
				ifTrue: [ methodName arguments: methodArguments ].
			methodName ].
	aRefactoring
		setOption: #useExistingMethod
			toUse: [ :ref1 :sel1 | receiver = 'self' and: [ isExisting ] ];
		setOption: #extractAssignment
			toUse: [ :ref1 :varName1 | 
				receiver = 'self'
					and: [ (aRefactoring model classFor: sourceCoderViewModel behavior)
							definesVariable: varName1 ] ]
]

{ #category : #testing }
GtExtractMethodToComponentController >> showReceiverType [
	(receiver sameContentAs: 'self') ifTrue: [ ^ false ].
	^ (sourceCoderViewModel behavior bindingOf: receiver asSymbol) value
		ifNotNil: [ :value | (value isBehavior and: [ value name = receiver ]) not ]
		ifNil: [ true ]
]

{ #category : #private }
GtExtractMethodToComponentController >> swap: firstNode with: secondNode [
	| aNewSourceText aFirstNode aSecondNode |
	aNewSourceText := self sourceText copy.
	firstNode startPosition < secondNode startPosition
		ifTrue:
			[ aFirstNode := firstNode.
			aSecondNode := secondNode ]
		ifFalse:
			[ aFirstNode := secondNode.
			aSecondNode := firstNode ].
	aNewSourceText := (aNewSourceText copyFrom: 1 to: aFirstNode startPosition - 1) , aSecondNode source asRopedText
		, (aNewSourceText copyFrom: aFirstNode stopPosition + 1 to: aSecondNode startPosition - 1) , aFirstNode source asRopedText
		,
			(aSecondNode stopPosition = aNewSourceText size
				ifTrue: [ '' asRopedText ]
				ifFalse: [ aNewSourceText copyFrom: aSecondNode stopPosition + 1 to: aNewSourceText size ]).
	self setText: aNewSourceText.
	self addReorderParametersAttributes.
	self installReceiverSelector
]

{ #category : #private }
GtExtractMethodToComponentController >> swapParameterWithNext: anInteger [
	| message |
	self removeAllAttributes.
	message := self findExtractedSend.
	message isNil ifTrue: [ ^ self ].
	methodArguments swap: anInteger with: anInteger + 1.
	self
		swap: (message values at: anInteger)
		with: (message values at: anInteger + 1).
	self addReorderParametersAttributes.
	self updateRenamer.
	self addRefactoringPreview
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
GtExtractMethodToComponentController >> updateExtractedMethodSourceFrom: aRefactoring [
	extractedMethod
		ifNil: [ | method |
			method := (aRefactoring model
					classNamed: (receiverClassName ifNil: [ sourceCoderViewModel behavior name ]))
					methodFor: self extractedSelector.
			method
				ifNil: [ (aRefactoring model allImplementorsOf: self extractedSelector)
						ifNotEmpty: [ :coll | 
							| cls |
							cls := coll anyOne.	"If we get here we are extracting to component & must have created a unique selector"
							potentialTypes ifNil: [ potentialTypes := GtPrefixTree with: cls name ].
							method := cls methodFor: self extractedSelector ] ].
			extractedMethod := method source ]
]

{ #category : #accessing }
GtExtractMethodToComponentController >> updateFromRefactoring: aRefactoring [
	| newSource |
	self updateExtractedMethodSourceFrom: aRefactoring.
	self resetNewSelectorIfNeeded.
	newSource := ((aRefactoring model classFor: sourceCoderViewModel behavior)
			methodFor: sourceCoderViewModel selector) source.
	self updateMethod: newSource
]

{ #category : #accessing }
GtExtractMethodToComponentController >> updateMethod: newSource [
	| newText |
	self sourceCoderViewModel selectNone.
	newText := newSource asRopedText glamorousCodeFontAndSize.
	self setText: newText.
	isExisting
		ifFalse: [ self preventSave.
			self installRenamer.
			self addRefactoringPreview.
			self installReceiverSelector ]
]

{ #category : #accessing }
GtExtractMethodToComponentController >> updateReceiverTo: aString [
	receiver := aString.
	receiverClassName := nil
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

{ #category : #private }
GtExtractMethodToComponentController >> updateSelector: aString at: anIndex [
	extractedSelectorKeywords at: anIndex put: aString
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
