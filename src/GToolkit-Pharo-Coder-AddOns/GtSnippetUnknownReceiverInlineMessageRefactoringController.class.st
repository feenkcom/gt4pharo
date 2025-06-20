Class {
	#name : #GtSnippetUnknownReceiverInlineMessageRefactoringController,
	#superclass : #GtMethodInlineMessageFromComponentRefactoringController,
	#instVars : [
		'returnLocation',
		'getterSelectors',
		'setterSelectors'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #'as yet unclassified' }
GtSnippetUnknownReceiverInlineMessageRefactoringController >> compileSnippetMethodIn: model [
	| cls ast source needsReturn |
	super compileSnippetMethodIn: model.
	self updateVariableReferencesIn: model.
	cls := model classFor: self snippetClass.
	ast := (cls methodFor: self snippetSelector) ast.
	needsReturn := ast lastIsReturn not.
	needsReturn ifFalse: [ ^ self ].
	source := cls sourceCodeFor: self snippetSelector.
	returnLocation := ast body statements last start - 1.
	cls
		compile: (source first: returnLocation) , '^' , (source allButFirst: returnLocation)
		classified: #accessing
]

{ #category : #executing }
GtSnippetUnknownReceiverInlineMessageRefactoringController >> createRefactoringModel [
	| model |
	model := Smalltalk createRbNamespace
			onEnvironment: RBBrowserEnvironment new.
	self compileSnippetMethodIn: model.
	self modelUpdater cull: model.
	^ model
]

{ #category : #'as yet unclassified' }
GtSnippetUnknownReceiverInlineMessageRefactoringController >> finishRefactoring: refactoring [
	| newText |
	super finishRefactoring: refactoring.
	newText := self refactoredSnippetCodeFrom: refactoring.
	self sourceCoderViewModel
		sourceText: newText asRopedText
		from: self
		synchronously: false
]

{ #category : #'as yet unclassified' }
GtSnippetUnknownReceiverInlineMessageRefactoringController >> getterSelectorFor: aString in: aRBClass [
	^ (aRBClass getterMethodFor: aString)
		ifNil: [ aRBClass superclass
				ifNotNil: [ :spr | 
					(spr definesInstanceVariable: aString)
						ifTrue: [ self getterSelectorFor: aString in: spr ] ] ]
]

{ #category : #'as yet unclassified' }
GtSnippetUnknownReceiverInlineMessageRefactoringController >> getterSendFor: aString in: aRBClass [
	^ (getterSelectors
		at: aString
		ifAbsentPut: [ self getterSelectorFor: aString in: aRBClass ])
		ifNotNil: [ :selector | RBMessageNode receiver: (RBVariableNode named: 'self') selector: selector ]
]

{ #category : #'as yet unclassified' }
GtSnippetUnknownReceiverInlineMessageRefactoringController >> initialize [
	super initialize.
	setterSelectors := Dictionary new.
	getterSelectors := Dictionary new
]

{ #category : #executing }
GtSnippetUnknownReceiverInlineMessageRefactoringController >> refactoring [
	| refactoring model |
	model := self createRefactoringModel.

	refactoring := self refactoringClass
			model: model
			inline: (self snippetIntervalFor: node sourceInterval)+ ((returnLocation notNil
							and: [ returnLocation < (self snippetIntervalFor: node sourceInterval) first ])
							ifTrue: [ 1 ]
							ifFalse: [ 0 ])
			inMethod: self snippetSelector
			forClass: self snippetClass.

	refactoring setOption: #inlineExpression toUse: [ :ref :string | false ].
	refactoring
		setOption: #implementorToInline
		toUse: [ :ref :classes | classes detect: [ :each | each realClass = self implementor ] ifNone: [ nil ] ].
	^ refactoring
]

{ #category : #'as yet unclassified' }
GtSnippetUnknownReceiverInlineMessageRefactoringController >> setterSelectorFor: aString in: aRBClass [
	^ (aRBClass setterMethodFor: aString)
		ifNil: [ aRBClass superclass
				ifNotNil: [ :spr | 
					(spr definesInstanceVariable: aString)
						ifTrue: [ self setterSelectorFor: aString in: spr ] ] ]
]

{ #category : #'as yet unclassified' }
GtSnippetUnknownReceiverInlineMessageRefactoringController >> setterSendFor: aString to: aNode in: aRBClass [
	^ (setterSelectors
		at: aString
		ifAbsentPut: [ self setterSelectorFor: aString in: aRBClass ])
		ifNotNil: [ :selector | 
			RBMessageNode
				receiver: (RBVariableNode named: 'self')
				selector: selector
				arguments: {aNode value copy} ]
]

{ #category : #'as yet unclassified' }
GtSnippetUnknownReceiverInlineMessageRefactoringController >> updateVariableReferencesIn: model [
	| cls method ast rewriter |
	(self snippetClass includesBehavior: self implementor) ifTrue: [ ^ self ].
	cls := model classFor: self implementor.
	method := cls methodFor: node selector.
	ast := method ast.
	rewriter := RBParseTreeRewriter new.
	self implementor allInstVarNames
		do: [ :each | 
			rewriter
				replace: each , ' := ``@a'
					withValueFrom: [ :n | 
						(self
							setterSendFor: each
							to: n value
							in: cls) ifNil: [ n copy ] ];
				replace: each
					withValueFrom: [ :n | (self getterSendFor: each in: cls) ifNil: [ n copy ] ] ].
	rewriter executeTree: ast.
	cls compile: ast formattedCode
]
