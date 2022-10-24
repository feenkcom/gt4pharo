Class {
	#name : #GtAbstractExtractMethodController,
	#superclass : #GtPharoSourceCoderRefactoringController,
	#instVars : [
		'methodArguments',
		'methodSelector',
		'isExisting',
		'extractedSelectorKeywords',
		'extractionInterval',
		'moveAttributes',
		'renameAction'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #private }
GtAbstractExtractMethodController >> addReorderParametersAttributes [
	| message |
	self removeReorderParametersAttributes.
	message := self findExtractedSend.
	message isNil ifTrue: [ ^ self ].
	self addReorderParametersAttributesOn: message
]

{ #category : #private }
GtAbstractExtractMethodController >> addReorderParametersAttributesOn: message [
	| attribute |
	extractedSelectorKeywords size > 1 ifFalse: [ ^ self ].
	moveAttributes := OrderedCollection new.
	message values
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
GtAbstractExtractMethodController >> cancelRefactoring [
	self cancelRenaming.
	self removeReorderParametersAttributes.
	super cancelRefactoring
]

{ #category : #private }
GtAbstractExtractMethodController >> cancelRenaming [
	self isRenaming ifTrue: [ renameAction cancel ]
]

{ #category : #executing }
GtAbstractExtractMethodController >> createModel [
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
GtAbstractExtractMethodController >> executeRefactoring [
	| refactoring model |
	refactoring := self refactoring.
	self setDefaultOptionsOn: refactoring.
	refactoring primitiveExecute.
	model := refactoring model.
	self updateFromModel: model
]

{ #category : #private }
GtAbstractExtractMethodController >> extractedSelector [
	^ (String
		streamContents:
			[ :stream | extractedSelectorKeywords do: [ :each | stream nextPutAll: each ] ])
		asSymbol
]

{ #category : #executing }
GtAbstractExtractMethodController >> extractionInterval [
	^ extractionInterval
		ifNil: [ | nodes |
			nodes := sourceCoderViewModel coderModel extractableNodesFrom: sourceCoderViewModel.
			nodes ifEmpty: [ ^ 1 to: 0 ].
			extractionInterval := nodes first startPosition to: nodes last stopPosition ]
]

{ #category : #private }
GtAbstractExtractMethodController >> findExtractedSend [
	[ self sourceAst
		withAllNodesOfType: GtPharoMessageNode
		do: [ :each | 
			(each selector = self extractedSelector
				and: [ ((1 to: methodArguments size)
						allSatisfy: [ :i | 
							(each arguments at: i) source = (methodArguments at: i)
								or: [ (each arguments at: i) source = 'self'
										and: [ ((methodArguments at: i)
												indexOfSubCollection: sourceCoderViewModel behavior name) > 0 ] ] ])
						and: [ (each parent receiver isKindOf: GtPharoVariableNode)
								and: [ each parent receiver name value = self receiver ] ] ])
				ifTrue: [ ^ each ] ] ] on: SmaCCParserError do: [ :ex | ^ nil ].
	^ nil
]

{ #category : #initialization }
GtAbstractExtractMethodController >> initialize [
	super initialize.
	moveAttributes := #()
]

{ #category : #private }
GtAbstractExtractMethodController >> installRenamer [
	self subclassResponsibility
]

{ #category : #testing }
GtAbstractExtractMethodController >> isRenaming [
	^ renameAction notNil and: [ renameAction isInstalled ]
]

{ #category : #private }
GtAbstractExtractMethodController >> isValidForPreview [
	^ self findExtractedSend notNil
]

{ #category : #private }
GtAbstractExtractMethodController >> newExtractedSelector [
	^ self extractedSelector
]

{ #category : #private }
GtAbstractExtractMethodController >> previewPosition [
	^ self findExtractedSend stopPosition
]

{ #category : #accessing }
GtAbstractExtractMethodController >> receiver [
	^ 'self'
]

{ #category : #executing }
GtAbstractExtractMethodController >> refactoring [
	| model |

	model := self createModel.

	^ RBExtractMethodRefactoring
		model: model
		extract: self extractionInterval
		from: methodSelector
		in: (model classFor: sourceCoderViewModel behavior)
]

{ #category : #executing }
GtAbstractExtractMethodController >> refactoringFailed [
	self sourceCoderViewModel allowSaveDueTo: self
]

{ #category : #accessing }
GtAbstractExtractMethodController >> refactoringName [
	^ 'Extract method'
]

{ #category : #private }
GtAbstractExtractMethodController >> removeRenaming [
	self isRenaming ifTrue: [ renameAction uninstall ]
]

{ #category : #private }
GtAbstractExtractMethodController >> removeReorderParametersAttributes [
	moveAttributes do: [ :each | self sourceCoderViewModel removeAttribute: each ]
]

{ #category : #private }
GtAbstractExtractMethodController >> safeMethodName: methodName in: aModel [
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
GtAbstractExtractMethodController >> safelyExecute [
	self createModel.
	self executeRefactoring
]

{ #category : #private }
GtAbstractExtractMethodController >> setDefaultOptionsOn: aRefactoring [
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

	aRefactoring
		setOption: #methodName
		toUse: [ :methodName | methodNameBlock value: aRefactoring value: methodName ].
	
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
GtAbstractExtractMethodController >> setPreviewOptionsOn: aRefactoring [
	| methodNameBlock |
	methodNameBlock := [ :ref :methodName |
		methodName
			selector: self newExtractedSelector;
			arguments: methodArguments;
			yourself ].


	aRefactoring
		setOption: #methodName
		toUse: [ :methodName | methodNameBlock value: aRefactoring value: methodName ].


	aRefactoring
		setOption: #useExistingMethod toUse: [ :ref :sel | isExisting ];
		setOption: #extractAssignment
			toUse:
				[ :ref :varName | (aRefactoring model classFor: sourceCoderViewModel behavior) definesVariable: varName ]
]

{ #category : #private }
GtAbstractExtractMethodController >> sourceAst [
	^ GtPharoParser
		parse: self sourceText characters asString
		startingAt: GtPharoParser startingStateForMethod
]

{ #category : #private }
GtAbstractExtractMethodController >> swap: firstNode with: secondNode [
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
GtAbstractExtractMethodController >> swapParameterWithNext: anInteger [
	| message |
	self removeReorderParametersAttributes.
	self removeRenaming.
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

{ #category : #executing }
GtAbstractExtractMethodController >> updateFromModel: aRBModel [
	| newSource |
	newSource := ((aRBModel classFor: sourceCoderViewModel behavior)
			methodFor: methodSelector) source.
	self updateMethod: newSource
]

{ #category : #private }
GtAbstractExtractMethodController >> updateMethod: newSource [
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

	self installRenamer.
	self addRefactoringPreview
]

{ #category : #private }
GtAbstractExtractMethodController >> updateRenamer [
	self subclassResponsibility
]

{ #category : #private }
GtAbstractExtractMethodController >> updateSelector: aString at: anIndex [
	extractedSelectorKeywords at: anIndex put: aString
]
