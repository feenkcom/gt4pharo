Class {
	#name : #GtExtractToParagraphRefactoringController,
	#superclass : #GtExtractMethodToComponentController,
	#instVars : [
		'className',
		'superclass',
		'category',
		'variables',
		'variableNames',
		'firstRun',
		'constructorMethodArguments',
		'actions',
		'generatedConstructorSelector',
		'constructorSelector'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #private }
GtExtractToParagraphRefactoringController >> addReorderConstructorParametersAttributesOn: message [
	| attribute |
	message arguments size > 1 ifFalse: [ ^ self ].
	moveAttributes := OrderedCollection new.
	message values
		keysAndValuesDo: [ :i :each | 
			i > 1
				ifTrue: [ attribute := GtReorderParametersAttribute
							action: [ self swapConstructorParameterWithNext: i - 1 ]
							icon: BrGlamorousVectorIcons left.
					moveAttributes add: attribute.
					self sourceCoderViewModel
						addTextAttribute: attribute
						from: each startPosition - 1
						to: each startPosition - 1 ].
			i < message values size
				ifTrue: [ attribute := GtReorderParametersAttribute
							action: [ self swapConstructorParameterWithNext: i ]
							icon: BrGlamorousVectorIcons right.
					moveAttributes add: attribute.
					self sourceCoderViewModel
						addTextAttribute: attribute
						from: each stopPosition
						to: each stopPosition ] ]
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> addReorderParametersAttributes [
	super addReorderParametersAttributes.
	self constructorSendDo: [ :each | self addReorderConstructorParametersAttributesOn: each ]
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> cancelRenaming [
	super cancelRenaming.
	actions do: [ :each | each isInstalled ifTrue: [ each cancel ] ]
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> category [
	^ category ifNil: [ sourceCoderViewModel behavior category ]
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> category: aSymbol [
	category := aSymbol
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> className [
	^ className ifNil: [ #NewClass ]
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> className: aSymbol [
	className := aSymbol
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> constructorSendDo: aBlock [
	| message |
	message := self findExtractedSend.
	message ifNil: [ ^ self ].
	message
		withAllNodesOfType: GtPharoMessageNode
		do: [ :each | each selector = generatedConstructorSelector ifTrue: [ aBlock value: each ] ]
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> findExtractedSend [
	[ self sourceAst
		withAllNodesOfType: GtPharoMessageNode
		do: [ :each | each selector = self extractedSelector ifTrue: [ ^ each ] ] ]
		on: SmaCCParserError
		do: [ :ex | ^ nil ].
	^ nil
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> getCurrentState [
	^ super getCurrentState , {variables copy}
]

{ #category : #initialization }
GtExtractToParagraphRefactoringController >> initialize [
	super initialize.
	firstRun := true.
	variables := OrderedCollection new.
	variableNames := Dictionary new.
	constructorSelector := #''.
	constructorMethodArguments := #().
	actions := #()
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> installRenamer [
	super installRenamer.
	actions := OrderedCollection new.
	self
		constructorSendDo: [ :each | 
			actions add: (self renameActionForReceiver: each parent receiver).
			actions add: (self renameActionForConstructor: each) ]
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> isParagraphReceiver: aString [
	^ aString includesSubstring: 'stream' caseSensitive: false
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> refactoring [
	| model |
	variableNames
		at: 'self'
		ifAbsentPut: [ (String with: sourceCoderViewModel behavior name first asLowercase)
				, sourceCoderViewModel behavior name allButFirst
				copyReplaceAll: ' class'
				with: 'Class' ].
	model := self createModel.
	^ (firstRun
		ifTrue: [ GtMethodObjectRefactoring ]
		ifFalse: [ GtExtractToParagraphRefactoring ]) new
		model: model;
		extract: self extractionInterval
			from: sourceCoderViewModel selector
			in: (model classFor: sourceCoderViewModel behavior);
		className: self className;
		superclass: self superclass;
		category: self category;
		variables: variables
			withAccessorNames: (variables collect: [ :each | variableNames at: each ifAbsent: [ each ] ]);
		setOption: #selfArgumentName toUse: [ :ref | self selfArgumentName ];
		setOption: #selectVariableToMoveTo
			toUse: [ :ref :cls :sel | receiver = 'self' ifTrue: [ self selfArgumentName ] ifFalse: [ receiver ] ];
		setOption: #variableTypes
			toUse: [ :ref :types :selected | 
				potentialTypes := GtPrefixTree withAll: (types collect: [ :each | each name ]).
				{ref model classNamed: self receiverClassName} ];
		yourself
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> refactoringName [
	^ 'Extract to paragraph'
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> renameActionForConstructor: node [
	| action |
	action := GtRenameSelectorAction
			message: node
			textualCoderViewModel: sourceCoderViewModel.
	action newSelector: constructorSelector.
	action selectAll: true.
	action focusedIndex: 0.
	action
		when: GtRenameActionAnnouncement
		do: [ :ann | 
			ann eventType = #textUpdated
				ifTrue: [ action isValid
						ifTrue: [ constructorSelector := action newSelector.
							self addRefactoringPreview ] ].
			ann eventType = #cancel ifTrue: [ self cancelRefactoring ] ].
	action install.
	^ action
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> renameActionForReceiver: aVariable [
	| action |
	action := GtCreateClassAction
			variable: aVariable
			textualCoderViewModel: sourceCoderViewModel.
	action requestInitialFocus: false.
	action package: sourceCoderViewModel behavior package name.
	sourceCoderViewModel behavior tags ifNotEmpty: [ :col | action tag: col first ].
	action selectAll: true.
	action
		when: GtRenameActionAnnouncement
		do: [ :ann | 
			ann eventType = #categoryUpdated
				ifTrue: [ self category: action category.
					self addRefactoringPreview ].
			ann eventType = #superclassUpdated
				ifTrue: [ self superclass: action superclass.
					self addRefactoringPreview ].
			ann eventType = #textUpdated
				ifTrue: [ action isValid
						ifTrue: [ self className: action newClassName asSymbol.
							self addRefactoringPreview ] ].
			ann eventType = #cancel ifTrue: [ self cancelRefactoring ] ].
	action install.
	^ action
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> setCurrentState: anArray [
	super setCurrentState: anArray.
	variables := anArray third copy
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> setDefaultOptionsOn: aRefactoring [
	super setDefaultOptionsOn: aRefactoring.
	aRefactoring
		setOption: #methodName
		toUse: [ :methodName :ref | 
			| selector |
			(methodArguments size = methodName arguments size
				and: [ methodArguments allSatisfy: [ :each | methodName arguments includes: each ] ])
				ifTrue: [ methodName arguments: methodArguments ]
				ifFalse: [ methodArguments := Array withAll: methodName arguments ].
			selector := ref uniqueMethodNameFor: methodName arguments size.
			selector numArgs = self extractedSelector numArgs
				ifTrue: [ selector := self extractedSelector ].
			extractedSelectorKeywords := selector keywords.
			methodName
				selector: selector;
				yourself ].
	aRefactoring
		setOption: #constructorMethodName
		toUse: [ :methodName :ref | 
			(constructorMethodArguments size = methodName arguments size
				and: [ constructorMethodArguments
						allSatisfy: [ :each | methodName arguments includes: each ] ])
				ifTrue: [ methodName arguments: constructorMethodArguments ]
				ifFalse: [ constructorMethodArguments := Array withAll: methodName arguments ].
			generatedConstructorSelector := ref
					uniqueMethodNameFor: methodName arguments size.
			generatedConstructorSelector numArgs = constructorSelector numArgs
				ifFalse: [ constructorSelector := self
							dummySelectorForArgs: generatedConstructorSelector numArgs ].
			methodName
				selector: generatedConstructorSelector;
				yourself ]
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> setDefaultValuesFor: aRefactoring [
	| vars send |
	(aRefactoring methodClass parseTreeFor: aRefactoring selector)
		nodesDo: [ :node | 
			(node isMessage and: [ node selector = self extractedSelector ])
				ifTrue: [ send := node ] ].
	vars := OrderedCollection
			withAll: (send arguments collect: [ :each | each name ]).
	potentialReceivers := vars copy.
	self setReceiverAndTypeFrom: vars.
	variables := vars copyWithout: receiver
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> setPreviewOptionsOn: aRefactoring [
	super setPreviewOptionsOn: aRefactoring.
	aRefactoring
		setOption: #constructorMethodName
		toUse: [ :methodName | 
			methodName
				selector: constructorSelector;
				arguments: constructorMethodArguments;
				yourself ]
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> setReceiverAndTypeFrom: potentialReceiverVariables [
	potentialReceiverVariables isEmpty
		ifTrue: [ self error: 'No variables are needed in the method' ].
	receiver := potentialReceiverVariables
			detect: [ :each | self isParagraphReceiver: each ]
			ifNone: [ potentialReceiverVariables first ].
	receiverClassName := nil
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> superclass [
	^ superclass ifNil: [ #Object ]
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> superclass: aSymbol [
	superclass := aSymbol
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> swapConstructorParameterWithNext: anInteger [
	self removeAllAttributes.
	self
		constructorSendDo: [ :message | 
			constructorMethodArguments swap: anInteger with: anInteger + 1.
			self
				swap: (message values at: anInteger)
				with: (message values at: anInteger + 1) ].
	self addReorderParametersAttributes.
	self updateRenamer.
	self addRefactoringPreview
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> updateFromRefactoring: aRefactoring [
	firstRun
		ifTrue: [ firstRun := false.
			self updateExtractedMethodSourceFrom: aRefactoring.
			self setDefaultValuesFor: aRefactoring.
			self safelyExecute ]
		ifFalse: [ super updateFromRefactoring: aRefactoring ]
]

{ #category : #accessing }
GtExtractToParagraphRefactoringController >> updateReceiverTo: aString [
	variables := (variables copyWithout: aString) copyWith: receiver.
	super updateReceiverTo: aString
]
