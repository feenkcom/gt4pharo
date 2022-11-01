Class {
	#name : #GtMethodObjectRefactoringController,
	#superclass : #GtExtractMethodToComponentController,
	#instVars : [
		'className',
		'superclass',
		'category',
		'variableAttributes',
		'variables',
		'variableNames',
		'variableRenamers',
		'firstRun'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #private }
GtMethodObjectRefactoringController >> addAsInstanceVariable: aString [
	self removeAllAttributes.
	self cancelRefactoring.
	self basicAddInstanceVariable: aString.
	self safelyExecute
]

{ #category : #private }
GtMethodObjectRefactoringController >> addReorderParametersAttributesOn: message [
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
GtMethodObjectRefactoringController >> basicAddInstanceVariable: aString [
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
GtMethodObjectRefactoringController >> cancelRenaming [
	super cancelRenaming.
	variableRenamers do: [ :each | each isInstalled ifTrue: [ each cancel ] ]
]

{ #category : #accessing }
GtMethodObjectRefactoringController >> category [
	^ category ifNil: [ sourceCoderViewModel behavior category ]
]

{ #category : #accessing }
GtMethodObjectRefactoringController >> category: aSymbol [
	category := aSymbol
]

{ #category : #accessing }
GtMethodObjectRefactoringController >> className [
	^ className ifNil: [ self initialClassName ]
]

{ #category : #accessing }
GtMethodObjectRefactoringController >> className: aSymbol [
	className := aSymbol
]

{ #category : #accessing }
GtMethodObjectRefactoringController >> initialClassName [
	^ #NewClass
]

{ #category : #initialization }
GtMethodObjectRefactoringController >> initialize [
	super initialize.
	firstRun := true.
	variableAttributes := #().
	variables := OrderedCollection new.
	variableNames := Dictionary new
]

{ #category : #accessing }
GtMethodObjectRefactoringController >> installRenamer [
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
GtMethodObjectRefactoringController >> isReceiver: receiverNode [
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
GtMethodObjectRefactoringController >> potentialReceivers [
	^ OrderedCollection with: self receiver
]

{ #category : #accessing }
GtMethodObjectRefactoringController >> receiver [
	^ self className
]

{ #category : #accessing }
GtMethodObjectRefactoringController >> receiverRenamerOn: aVariable [
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
GtMethodObjectRefactoringController >> refactoring [
	| model refactoring |
	model := self createModel.
	refactoring := GtMethodObjectRefactoring new
			model: model;
			extract: self extractionInterval
				from: sourceCoderViewModel selector
				in: (model classFor: sourceCoderViewModel behavior);
			className: self className;
			superclass: self superclass;
			category: self category;
			variables: variables
				withAccessorNames: (variables collect: [ :each | variableNames at: each ifAbsent: [ each ] ]);
			yourself.
	refactoring
		setOption: #selfArgumentName
		toUse: [ :ref | self selfArgumentName ].

	^ refactoring
]

{ #category : #accessing }
GtMethodObjectRefactoringController >> refactoringName [
	^ 'Create method object'
]

{ #category : #'private - attributes' }
GtMethodObjectRefactoringController >> removeAllAttributes [
	super removeAllAttributes.
	self removeVariableAttributes
]

{ #category : #private }
GtMethodObjectRefactoringController >> removeInstanceVariable: aString [
	self removeAllAttributes.
	self cancelRefactoring.
	variables remove: aString ifAbsent: [  ].
	self safelyExecute
]

{ #category : #accessing }
GtMethodObjectRefactoringController >> removeRenaming [
	super removeRenaming.
	variableRenamers do: [ :each | each uninstall ]
]

{ #category : #private }
GtMethodObjectRefactoringController >> removeVariableAttributes [
	variableAttributes
		do: [ :each | self sourceCoderViewModel removeCoderTextAttributes: each ]
]

{ #category : #accessing }
GtMethodObjectRefactoringController >> renameActionForSetter: node [
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
GtMethodObjectRefactoringController >> setDefaultValuesOnFirstRun [
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
GtMethodObjectRefactoringController >> superclass [
	^ superclass ifNil: [ #Object ]
]

{ #category : #accessing }
GtMethodObjectRefactoringController >> superclass: aSymbol [
	superclass := aSymbol
]

{ #category : #accessing }
GtMethodObjectRefactoringController >> updateFromRefactoring: aRefactoring [
	super updateFromRefactoring: aRefactoring.
	self setDefaultValuesOnFirstRun
]
