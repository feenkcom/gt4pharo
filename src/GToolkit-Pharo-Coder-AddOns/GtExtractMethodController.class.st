Class {
	#name : #GtExtractMethodController,
	#superclass : #GtPharoSourceCoderRefactoringController,
	#instVars : [
		'methodArguments',
		'methodSelector',
		'isExisting',
		'extractedSelectorKeywords',
		'renameAction',
		'renameIndex',
		'extractionInterval',
		'moveAttributes'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #private }
GtExtractMethodController >> addRefactoringPreview [
	| message refactoring |

	message := self findExtractedSend.
	message
		"refactoring failed"
		ifNil: [ ^ self ].
	
	refactoring := self refactoring.

	self setPreviewOptionsOn: refactoring.
	self
		addRefactoringChangesPreview: refactoring
		at: message stopPosition
		whenComplete: [
			self removeRefactoringAttribute.
			self allowSave ]
]

{ #category : #private }
GtExtractMethodController >> addReorderParametersAttributes [
	| message text attribute |
	self removeReorderParametersAttributes.
	extractedSelectorKeywords size > 1 ifFalse: [ ^ self ].
	message := self findExtractedSend.
	message isNil ifTrue: [ ^ self ].
	text := self sourceText.
	moveAttributes := OrderedCollection new.
	(message isBinary ifTrue: [ {message value} ] ifFalse: [ message values ])
		keysAndValuesDo:
			[ :i :each | 
			i > 1
				ifTrue:
					[ attribute := GtExtractMethodReorderParametersAttribute
						action: [ self swapParameterWithNext: i - 1 ]
						icon: BrGlamorousVectorIcons left.
					moveAttributes add: attribute.
					self sourceCoderViewModel
						addTextAttribute: attribute
						from: each startPosition - 1
						to: each startPosition - 1 ].
			i < message values size
				ifTrue:
					[ attribute := GtExtractMethodReorderParametersAttribute
						action: [ self swapParameterWithNext: i ]
						icon: BrGlamorousVectorIcons right.
					moveAttributes add: attribute.
					self sourceCoderViewModel
						addTextAttribute: attribute
						from: each stopPosition
						to: each stopPosition ] ]
]

{ #category : #executing }
GtExtractMethodController >> cancelRefactoring [
	self isRenaming
		ifTrue: [ renameAction cancel ].
	
	self restoreText.
	self allowSave
]

{ #category : #executing }
GtExtractMethodController >> createModel [
	| model modelClass |
	
	model := RBClassModelFactory rbNamespace
		onEnvironment: RBBrowserEnvironment new.
	model name: self refactoringName.
	
	modelClass := model classFor: sourceCoderViewModel behavior.
	methodSelector := sourceCoderViewModel selector.

	(modelClass sourceCodeFor: methodSelector) = originalSource asString
		ifFalse: [ modelClass
				compile: originalSource asString
				classified: sourceCoderViewModel protocol ].
	^ model
]

{ #category : #executing }
GtExtractMethodController >> executeRefactoring [
	| refactoring newSource |

	refactoring := self refactoring.
	self setDefaultOptionsOn: refactoring.
	refactoring primitiveExecute.

	newSource := ((refactoring model classFor: sourceCoderViewModel behavior) methodFor: methodSelector) source.
	self updateMethod: newSource
]

{ #category : #private }
GtExtractMethodController >> extractedSelector [
	^ (String
		streamContents:
			[ :stream | extractedSelectorKeywords do: [ :each | stream nextPutAll: each ] ])
		asSymbol
]

{ #category : #executing }
GtExtractMethodController >> extractionInterval [
	^ extractionInterval
		ifNil: [ | nodes |
			nodes := sourceCoderViewModel coderModel extractableNodesFrom: sourceCoderViewModel.
			nodes ifEmpty: [ ^ 1 to: 0 ].
			extractionInterval := nodes first startPosition to: nodes last stopPosition ]
]

{ #category : #private }
GtExtractMethodController >> findExtractedSend [
	[ self sourceAst
		withAllNodesOfType: GtPharoMessageNode
		do:
			[ :each | 
			(each selector = self extractedSelector
				and:
					[ ((1 to: methodArguments size)
						allSatisfy:
							[ :i | (each isBinary ifTrue: [ each value ] ifFalse: [ each values at: i ]) source = (methodArguments at: i) ])
						and: [ (each parent receiver isKindOf: GtPharoVariableNode) and: [ each parent receiver name value = 'self' ] ] ])
				ifTrue: [ ^ each ] ] ] on: SmaCCParserError do: [ :ex | ^ nil ].
	^ nil
]

{ #category : #initialization }
GtExtractMethodController >> initialize [
	super initialize.
	moveAttributes := #()
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
	
	renameAction := GtRenameAction2
		locations: { interval }
		textualCoderViewModel: sourceCoderViewModel.
	
	renameAction selectAll: true.

	renameAction
		when: GtRenameActionAnnouncement
		do: [ :ann | 
			ann eventType = #textUpdated
				ifTrue: [ self updateSelector: renameAction newName ].
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

{ #category : #testing }
GtExtractMethodController >> isRenaming [
	^ renameAction notNil and: [ renameAction isInstalled ]
]

{ #category : #executing }
GtExtractMethodController >> refactoring [
	| model |

	model := self createModel.

	^ RBExtractMethodRefactoring
		model: model
		extract: self extractionInterval
		from: methodSelector
		in: (model classFor: sourceCoderViewModel behavior)
]

{ #category : #executing }
GtExtractMethodController >> refactoringFailed [
	self sourceCoderViewModel allowSaveDueTo: self
]

{ #category : #accessing }
GtExtractMethodController >> refactoringName [
	^ 'Extract method'
]

{ #category : #private }
GtExtractMethodController >> removeReorderParametersAttributes [
	moveAttributes do: [ :each | self sourceCoderViewModel removeAttribute: each ]
]

{ #category : #private }
GtExtractMethodController >> safeMethodName: methodName in: aModel [
	| modelClass index selector name argCount |

	modelClass := aModel classFor: sourceCoderViewModel behavior.
	argCount := methodName arguments size.
	name := '_'.
	index := 0.
	[ selector := (String
		streamContents: [ :stream | 
			stream nextPutAll: name.
			argCount >= 1
				ifTrue: [ stream nextPut: $:.
					2 to: argCount do: [ :i | stream nextPutAll: '_:' ] ] ]) asSymbol.
	modelClass hierarchyDefinesMethod: selector ]
		whileTrue: [ name := name , index printString.
			index := index + 1 ].
	^ selector
]

{ #category : #executing }
GtExtractMethodController >> safelyExecute [
	self createModel.
	self executeRefactoring
]

{ #category : #private }
GtExtractMethodController >> setBodyText: bodySource andAttributesAt: positions [
	| bodyText |
	bodyText := bodySource asRopedText.
	positions
		keysAndValuesDo: [ :i :each | 
			(bodyText from: each to: each)
				attributes:
					{GtCompletionPartAttribute new.
					(GtExtractMethodSelectorKeywordAttribute keywordIndex: i)} ].
	self setText: bodyText
]

{ #category : #private }
GtExtractMethodController >> setDefaultOptionsOn: aRefactoring [
	| methodNameBlock |
	isExisting := false.
	
	methodNameBlock := [ :ref :methodName |
		| selector |
		methodArguments := Array withAll: methodName arguments.
		selector := self safeMethodName: methodName in: ref model.
		extractedSelectorKeywords := selector keywords.
		methodName
			selector: selector;
			yourself ].

	self
		forPharo8: [
			aRefactoring
				setOption: #methodName
				toUse: [ :ref :methodName | methodNameBlock value: ref value: methodName  ] ]
		forPharo9: [
			aRefactoring
				setOption: #methodName
				toUse: [ :methodName | methodNameBlock value: aRefactoring value: methodName  ] ].
	
	aRefactoring
		setOption: #useExistingMethod
			toUse: [ :ref :sel | 
			extractedSelectorKeywords := sel keywords.
			isExisting := true ];
		setOption: #extractAssignment
			toUse:
				[ :ref :varName | (aRefactoring model classFor: sourceCoderViewModel behavior) definesVariable: varName ]
]

{ #category : #private }
GtExtractMethodController >> setPreviewOptionsOn: aRefactoring [
	| methodNameBlock |
	methodNameBlock := [ :ref :methodName |
		methodName
			selector: self extractedSelector;
			arguments: methodArguments;
			yourself ].

	self
		forPharo8: [
			aRefactoring
				setOption: #methodName
				toUse: [ :ref :methodName | methodNameBlock value: ref value: methodName  ] ]
		forPharo9: [
			aRefactoring
				setOption: #methodName
				toUse: [ :methodName | methodNameBlock value: aRefactoring value: methodName  ] ].


	aRefactoring
		setOption: #useExistingMethod toUse: [ :ref :sel | isExisting ];
		setOption: #extractAssignment
			toUse:
				[ :ref :varName | (aRefactoring model classFor: sourceCoderViewModel behavior) definesVariable: varName ]
]

{ #category : #private }
GtExtractMethodController >> sourceAst [
	^ GtPharoParser
		parse: self sourceText characters asString
		startingAt: GtPharoParser startingStateForMethod
]

{ #category : #private }
GtExtractMethodController >> swap: firstNode with: secondNode [
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
	self addReorderParametersAttributes
]

{ #category : #private }
GtExtractMethodController >> swapParameterWithNext: anInteger [
	| message |
	self removeReorderParametersAttributes.
	self isRenaming
		ifTrue: [ renameAction uninstall ].
	message := self findExtractedSend.
	message isNil
		ifTrue: [ ^ self ].
	methodArguments swap: anInteger with: anInteger + 1.
	self
		swap: (message values at: anInteger)
		with: (message values at: anInteger + 1).
	self addReorderParametersAttributes.
	renameIndex notNil
		ifTrue: [ self installRenamerAt: renameIndex ].
	self addRefactoringPreview
]

{ #category : #private }
GtExtractMethodController >> updateMethod: newSource [
	| newText |
	self sourceCoderViewModel selectNone.
	newText := newSource asRopedText glamorousCodeFontAndSize.
	self setText: newText.

	"refactoring decided that there is an existing method that can be used instead
	of creating a new one. In this case there is no need to spawn a renamer"
	isExisting
		ifTrue: [ ^ self ].

	"At this point saving is undefined, we disable it until refactoring is applied or canceled"
	self preventSave.

	self installRenamerAt: 1.
	self addRefactoringPreview
]

{ #category : #private }
GtExtractMethodController >> updateSelector: aString [
	extractedSelectorKeywords at: renameIndex put: aString
]
