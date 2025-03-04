Class {
	#name : #GtExtractToWrappedMethodObjectRefactoringController,
	#superclass : #GtExtractMethodToComponentController,
	#instVars : [
		'className',
		'superclass',
		'category',
		'constructorMethodArguments',
		'actions',
		'generatedConstructorSelector',
		'constructorSelector'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #private }
GtExtractToWrappedMethodObjectRefactoringController >> addReorderConstructorParametersAttributesOn: message [
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

{ #category : #private }
GtExtractToWrappedMethodObjectRefactoringController >> addReorderParametersAttributes [
]

{ #category : #executing }
GtExtractToWrappedMethodObjectRefactoringController >> cancelRenaming [
	super cancelRenaming.
	actions do: [ :each | each isInstalled ifTrue: [ each cancel ] ]
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoringController >> category [
	^ category ifNil: [ sourceCoderViewModel behavior category ]
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoringController >> category: aSymbol [
	category := aSymbol
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoringController >> className [
	^ className ifNil: [ self initialClassName ]
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoringController >> className: aSymbol [
	className := aSymbol
]

{ #category : #private }
GtExtractToWrappedMethodObjectRefactoringController >> constructorSendDo: aBlock [
	[ self sourceAst
		withAllNodesOfType: GtPharoVariableNode
		do: [ :each | 
			(each variableName = self initialClassName
				or: [ each variableName = self className ])
				ifTrue: [ | constructor |
					constructor := each parent.
					(constructor parent isCascade
						and: [ constructor parent receiver == constructor ])
						ifTrue: [ constructor := constructor parent ].
					constructor parent isMessage ifTrue: [ ^ aBlock value: constructor ] ] ] ]
		on: SmaCCParserError
		do: [ :ex |  ]
]

{ #category : #private }
GtExtractToWrappedMethodObjectRefactoringController >> findExtractedSend [
	self constructorSendDo: [ :each | ^ each parent ].
	^ nil
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoringController >> initialClassName [
	^ #NewClass
]

{ #category : #initialization }
GtExtractToWrappedMethodObjectRefactoringController >> initialize [
	super initialize.
	constructorSelector := #''.
	constructorMethodArguments := #().
	actions := #()
]

{ #category : #installation }
GtExtractToWrappedMethodObjectRefactoringController >> installReceiverSelector [
]

{ #category : #installation }
GtExtractToWrappedMethodObjectRefactoringController >> installRenamer [
	| foundConstructor |
	self addRefactoringPreview.

	foundConstructor := false.
	actions := OrderedCollection new.
	self
		constructorSendDo: [ :each | 
			foundConstructor := true.
			each isCascade
				ifTrue: [ actions add: (self renameActionForReceiver: each receiver receiver) ]
				ifFalse: [ actions add: (self renameActionForReceiver: each receiver).
					actions add: (self renameActionForConstructor: each message).
					self addReorderConstructorParametersAttributesOn: each message ] ].
	foundConstructor ifFalse: [ self cancelRefactoring ]
]

{ #category : #testing }
GtExtractToWrappedMethodObjectRefactoringController >> isValidForPreview [
	self constructorSendDo: [ :each | ^ true ].
	^ false
]

{ #category : #private }
GtExtractToWrappedMethodObjectRefactoringController >> methodObjectMethodName: methodName in: ref [
	"methodName selector: #mySelector:; arguments: (...)."

	| selector |
	(methodArguments size = methodName arguments size
		and: [ methodArguments allSatisfy: [ :each | methodName arguments includes: each ] ])
		ifTrue: [ methodName arguments: methodArguments ]
		ifFalse: [ methodArguments := Array withAll: methodName arguments ].
	selector := self methodObjectSelectorFor: methodName in: ref.
	extractedSelectorKeywords := selector keywords.
	^ methodName
		selector: selector;
		yourself
]

{ #category : #customization }
GtExtractToWrappedMethodObjectRefactoringController >> methodObjectSelectorFor: methodName in: ref [
	"^ #methodObject:"

	| selector |
	selector := ref uniqueMethodNameFor: methodName arguments size.
	selector numArgs = self extractedSelector numArgs
		ifTrue: [ selector := self extractedSelector ].
	^ selector
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoringController >> refactoring [
	| model |
	model := self createModel.
	^ GtExtractToWrappedMethodObjectRefactoring new
		model: model;
		extract: self extractionInterval
			from: sourceCoderViewModel selector
			in: (model classFor: sourceCoderViewModel behavior);
		className: self className;
		superclass: self superclass;
		category: self category;
		setOption: #variablesToMove
			toUse: [ :potential :ref | self variablesToMove: potential ];
		setOption: #newVariableName
			toUse: [ :oldName :ref | self variableNameFor: oldName ];
		setOption: #wrappedReceiver
			toUse: [ :receivers :ref | self wrappedReceiverFrom: receivers ];
		setOption: #wrappedMethodName
			toUse: [ :methodName :ref | self wrappedMethodName: methodName in: ref ];
		setOption: #selfArgumentName toUse: [ :ref | self selfArgumentName ];
		setOption: #selectVariableToMoveTo
			toUse: [ :ref :cls :sel | receiver = 'self' ifTrue: [ self selfArgumentName ] ifFalse: [ receiver ] ];
		setOption: #variableTypes
			toUse: [ :ref :types :selected | 
				potentialTypes := GtPrefixTree withAll: (types collect: [ :each | each name ]).
				{ref model classNamed: self receiverClassName} ];
		setOption: #methodProtocol toUse: [ :sel :ref | self wrappedMethodProtocol ];
		yourself
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoringController >> refactoringName [
	^ 'Extract to paragraph'
]

{ #category : #private }
GtExtractToWrappedMethodObjectRefactoringController >> renameActionForConstructor: node [
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

{ #category : #private }
GtExtractToWrappedMethodObjectRefactoringController >> renameActionForReceiver: aVariable [
	| action |
	action := GtCreateClassAction
			variable: aVariable
			textualCoderViewModel: sourceCoderViewModel.
	action requestInitialFocus: true.
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

{ #category : #executing }
GtExtractToWrappedMethodObjectRefactoringController >> setDefaultOptionsOn: aRefactoring [
	super setDefaultOptionsOn: aRefactoring.
	aRefactoring
		setOption: #methodName
			toUse: [ :methodName :ref | self methodObjectMethodName: methodName in: ref ];
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

{ #category : #executing }
GtExtractToWrappedMethodObjectRefactoringController >> setPreviewOptionsOn: aRefactoring [
	super setPreviewOptionsOn: aRefactoring.
	aRefactoring
		setOption: #methodName
			toUse: [ :methodName :ref | self methodObjectMethodName: methodName in: ref ];
		setOption: #constructorMethodName
			toUse: [ :methodName | 
				methodName
					selector: constructorSelector;
					arguments: constructorMethodArguments;
					yourself ]
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoringController >> superclass [
	^ superclass ifNil: [ #Object ]
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoringController >> superclass: aSymbol [
	superclass := aSymbol
]

{ #category : #private }
GtExtractToWrappedMethodObjectRefactoringController >> swapConstructorParameterWithNext: anInteger [
	self removeAllAttributes.
	self
		constructorSendDo: [ :each | 
			constructorMethodArguments swap: anInteger with: anInteger + 1.
			self
				swap: (each message values at: anInteger)
				with: (each message values at: anInteger + 1) ].
	self addReorderParametersAttributes.
	self updateRenamer.
	self addRefactoringPreview
]

{ #category : #customization }
GtExtractToWrappedMethodObjectRefactoringController >> variableNameFor: oldName [
	"name for the variable in the method object"

	oldName = 'self'
		ifTrue: [ ^ (String with: sourceCoderViewModel behavior name first asLowercase)
				, sourceCoderViewModel behavior name allButFirst
				copyReplaceAll: ' class'
				with: 'Class' ].
	^ oldName
]

{ #category : #customization }
GtExtractToWrappedMethodObjectRefactoringController >> variablesToMove: potential [
	"variables that should be in the method object"

	^ potential copyWithout: (self wrappedReceiverFrom: potential)
]

{ #category : #private }
GtExtractToWrappedMethodObjectRefactoringController >> wrappedMethodName: methodName in: aRefactoring [
	methodName
		selector: (self wrappedMethodSelectorFor: methodName in: aRefactoring).
	^ methodName
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoringController >> wrappedMethodProtocol [
	^ #writing
]

{ #category : #customization }
GtExtractToWrappedMethodObjectRefactoringController >> wrappedMethodSelectorFor: methodName in: aRefactoring [
	"^ #mySelector:"

	^ methodName selector
]

{ #category : #customization }
GtExtractToWrappedMethodObjectRefactoringController >> wrappedReceiverFrom: receivers [
	"^receivers detect: [:each | each includesSubstring: 'var' caseSensitive: false]"

	self ast variables
		do: [ :each | (receivers includes: each variableName) ifTrue: [ ^ each variableName ] ].

	^ receivers first
]
