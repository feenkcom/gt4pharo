Class {
	#name : #GtExtractMethodObjectRefactoringController,
	#superclass : #GtExtractMethodToComponentController,
	#instVars : [
		'className',
		'superclass',
		'category',
		'variableAttributes',
		'variables',
		'variableNames',
		'variableRenamers',
		'firstRun',
		'initialClassName'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #private }
GtExtractMethodObjectRefactoringController >> addAsInstanceVariable: aString [
	self removeAllAttributes.
	self cancelRefactoring.
	self basicAddInstanceVariable: aString.
	self safelyExecute
]

{ #category : #private }
GtExtractMethodObjectRefactoringController >> addReorderParametersAttributesOn: message [
	| attribute |
	super addReorderParametersAttributesOn: message.
	self removeVariableAttributes.
	variableAttributes := OrderedCollection new.
	(variables notEmpty and: [ message parent isCascade ])
		ifTrue: [ 1
				to: message parent messages size - 1
				do: [ :i | 
					| node |
					node := (message parent messages at: i) arguments first.
					attribute := GtReorderParametersAttribute
							action: [ self removeInstanceVariable: node source ]
							icon: BrGlamorousVectorIcons down
							label: 'Remove from object state'.
					variableAttributes
						add: (self sourceCoderViewModel
								addTextAttribute: attribute
								from: node stopPosition
								to: node stopPosition) ] ].
	message arguments
		do: [ :each | 
			attribute := GtReorderParametersAttribute
					action: [ self addAsInstanceVariable: each source ]
					icon: BrGlamorousVectorIcons up
					label: 'Add as object state'.
			variableAttributes
				add: (self sourceCoderViewModel
						addTextAttribute: attribute
						from: each stopPosition
						to: each stopPosition) ]
]

{ #category : #private }
GtExtractMethodObjectRefactoringController >> basicAddInstanceVariable: aString [
	variables add: aString.
	aString = 'self'
		ifTrue: [ variableNames
				at: aString
				ifAbsentPut: [ (String with: sourceCoderViewModel behavior name first asLowercase)
						, sourceCoderViewModel behavior name allButFirst
						copyReplaceAll: ' class'
						with: 'Class' ] ]
]

{ #category : #accessing }
GtExtractMethodObjectRefactoringController >> cancelRenaming [
	super cancelRenaming.
	variableRenamers
		ifNotNil: [ variableRenamers do: [ :each | each isInstalled ifTrue: [ each cancel ] ] ]
]

{ #category : #accessing }
GtExtractMethodObjectRefactoringController >> category [
	^ category ifNil: [ sourceCoderViewModel behavior category ]
]

{ #category : #accessing }
GtExtractMethodObjectRefactoringController >> category: aSymbol [
	category := aSymbol
]

{ #category : #accessing }
GtExtractMethodObjectRefactoringController >> className [
	^ className ifNil: [ self initialClassName ]
]

{ #category : #accessing }
GtExtractMethodObjectRefactoringController >> className: aSymbol [
	className := aSymbol
]

{ #category : #accessing }
GtExtractMethodObjectRefactoringController >> initialClassName [
	^ initialClassName
		ifNil: [ | index |
			index := 1.
			initialClassName := #NewClass.
			[ Smalltalk includesKey: initialClassName ]
				whileTrue: [ initialClassName := ('NewClass' , index printString) asSymbol.
					index := index + 1 ].
			initialClassName ]
]

{ #category : #initialization }
GtExtractMethodObjectRefactoringController >> initialize [
	super initialize.
	firstRun := true.
	variableAttributes := #().
	variables := OrderedCollection new.
	variableNames := Dictionary new
]

{ #category : #accessing }
GtExtractMethodObjectRefactoringController >> installRenamer [
	| message |
	super installRenamer.

	message := self findExtractedSend.
	message isNil ifTrue: [ ^ self ].

	variableRenamers := OrderedCollection new.
	(variables notEmpty and: [ message parent isCascade ])
		ifTrue: [ 1
				to: message parent messages size - 1
				do: [ :i | 
					| node |
					node := message parent messages at: i.
					variableRenamers add: (self renameActionForSetter: node) ] ].
	variableRenamers
		add: (self receiverRenamerOn: message parent receiver receiver)
]

{ #category : #testing }
GtExtractMethodObjectRefactoringController >> isReceiver: receiverNode [
	| aNode |
	(variables isEmpty and: [ receiverNode isCascade ])
		ifTrue: [ receiverNode messages last selector = #yourself ifFalse: [ ^ false ].
			aNode := receiverNode receiver ]
		ifFalse: [ aNode := receiverNode ].
	^ (aNode isKindOf: GtPharoMessageSendNode)
		and: [ (aNode receiver isKindOf: GtPharoVariableNode)
				and: [ ({self className.
						self initialClassName} includes: aNode receiver name value)
						and: [ aNode selector = #new ] ] ]
]

{ #category : #private }
GtExtractMethodObjectRefactoringController >> potentialReceivers [
	^ OrderedCollection with: self receiver
]

{ #category : #accessing }
GtExtractMethodObjectRefactoringController >> receiver [
	^ self className
]

{ #category : #accessing }
GtExtractMethodObjectRefactoringController >> receiverRenamerOn: aVariable [
	| action |
	action := GtCreateClassAction
			variable: aVariable
			textualCoderViewModel: sourceCoderViewModel.
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
GtExtractMethodObjectRefactoringController >> refactoring [
	| model refactoring |
	model := self createModel.
	refactoring := GtExtractMethodObjectRefactoring new
			model: model;
			extract: self extractionInterval
				from: sourceCoderViewModel selector
				in: (model classFor: sourceCoderViewModel behavior);
			className: self className;
			superclass: self superclass;
			category: self category;
			yourself.
	refactoring
		setOption: #variablesToMove toUse: [ :potential :ref | variables ];
		setOption: #newVariableName
			toUse: [ :oldName :ref | variableNames at: oldName ifAbsent: [ oldName ] ];
		setOption: #selfArgumentName toUse: [ :ref | self selfArgumentName ].

	^ refactoring
]

{ #category : #accessing }
GtExtractMethodObjectRefactoringController >> refactoringName [
	^ 'Extract method object'
]

{ #category : #'private - attributes' }
GtExtractMethodObjectRefactoringController >> removeAllAttributes [
	super removeAllAttributes.
	self removeVariableAttributes
]

{ #category : #private }
GtExtractMethodObjectRefactoringController >> removeInstanceVariable: aString [
	self removeAllAttributes.
	self cancelRefactoring.
	variables remove: aString ifAbsent: [  ].
	self safelyExecute
]

{ #category : #accessing }
GtExtractMethodObjectRefactoringController >> removeRenaming [
	super removeRenaming.
	variableRenamers
		ifNotNil: [ variableRenamers do: [ :each | each isInstalled ifTrue: [ each cancel ] ] ]
]

{ #category : #private }
GtExtractMethodObjectRefactoringController >> removeVariableAttributes [
	variableAttributes
		do: [ :each | self sourceCoderViewModel removeCoderTextAttributes: each ]
]

{ #category : #accessing }
GtExtractMethodObjectRefactoringController >> renameActionForSetter: node [
	| action |
	action := GtRenameSelectorAction
			message: node
			textualCoderViewModel: sourceCoderViewModel.
	action selectAll: true.
	action
		when: GtRenameActionAnnouncement
		do: [ :ann | 
			ann eventType = #textUpdated
				ifTrue: [ action isValid
						ifTrue: [ variableNames
								at: node arguments first source
								put: action newSelector asString allButLast.
							self addRefactoringPreview ] ].
			ann eventType = #cancel ifTrue: [ self cancelRefactoring ] ].
	action install.
	^ action
]

{ #category : #accessing }
GtExtractMethodObjectRefactoringController >> setDefaultValuesOnFirstRun [
	| vars selectorParts args originalAst |
	firstRun ifFalse: [ ^ self ].
	firstRun := false.
	vars := OrderedCollection
			withAll: (self findExtractedSend arguments collect: [ :each | each source ]).
	originalAst := self sourceAst.
	selectorParts := OrderedCollection new.
	args := OrderedCollection new.
	originalAst variables notEmpty
		ifTrue: [ 1
				to: originalAst variables size
				do: [ :i | 
					(vars includes: (originalAst variables at: i) source)
						ifTrue: [ args add: (originalAst variables at: i) source.
							selectorParts add: (originalAst selectorParts at: i) source ] ] ].
	vars removeAll: args.
	self removeAllAttributes.
	self cancelRefactoring.
	vars do: [ :each | self basicAddInstanceVariable: each ].
	methodArguments := args.
	extractedSelectorKeywords := selectorParts.
	self safelyExecute
]

{ #category : #accessing }
GtExtractMethodObjectRefactoringController >> superclass [
	^ superclass ifNil: [ #Object ]
]

{ #category : #accessing }
GtExtractMethodObjectRefactoringController >> superclass: aSymbol [
	superclass := aSymbol
]

{ #category : #accessing }
GtExtractMethodObjectRefactoringController >> updateFromRefactoring: aRefactoring [
	super updateFromRefactoring: aRefactoring.
	self setDefaultValuesOnFirstRun
]
