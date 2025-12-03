Class {
	#name : #GtSnippetInlineMessageRefactoringController,
	#superclass : #GtPharoSourceCoderRefactoringController,
	#instVars : [
		'messageNode',
		'implementorClass',
		'returnLocation',
		'setterSelectors',
		'getterSelectors',
		'snippetClass'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #accessing }
GtSnippetInlineMessageRefactoringController >> compileSnippetMethodIn: model [
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

{ #category : #private }
GtSnippetInlineMessageRefactoringController >> getterSelectorFor: aString in: aRBClass [
	^ (aRBClass getterMethodFor: aString)
		ifNil: [ aRBClass superclass
				ifNotNil: [ :spr | 
					(spr definesInstanceVariable: aString)
						ifTrue: [ self getterSelectorFor: aString in: spr ] ] ]
]

{ #category : #private }
GtSnippetInlineMessageRefactoringController >> getterSendFor: aString in: aRBClass [
	^ (getterSelectors
		at: aString
		ifAbsentPut: [ self getterSelectorFor: aString in: aRBClass ])
		ifNotNil: [ :selector | RBMessageNode receiver: (RBVariableNode named: 'self') selector: selector ]
]

{ #category : #accessing }
GtSnippetInlineMessageRefactoringController >> implementorClass: aClass [
	implementorClass := aClass
]

{ #category : #'as yet unclassified' }
GtSnippetInlineMessageRefactoringController >> initialize [
	super initialize.
	setterSelectors := Dictionary new.
	getterSelectors := Dictionary new
]

{ #category : #accessing }
GtSnippetInlineMessageRefactoringController >> messageNode: aGtPharoMessageSendNode [
	messageNode := aGtPharoMessageSendNode
]

{ #category : #accessing }
GtSnippetInlineMessageRefactoringController >> refactoring [
	| model refactoring |
	model := self createSnippetRefactoringModel.
	refactoring := ((messageNode receiver isSelf
			or: [ messageNode receiver isSuper ])
			ifTrue: [ GtInlineMethodRefactoring ]
			ifFalse: [ GtInlineMethodFromComponentRefactoring ])
			model: model
			inline: (self snippetIntervalFor: messageNode sourceInterval)
					+ ((returnLocation notNil
							and: [ returnLocation < (self snippetIntervalFor: messageNode sourceInterval) first ])
							ifTrue: [ 1 ]
							ifFalse: [ 0 ])
			inMethod: self snippetSelector
			forClass: self snippetClass.
	refactoring
		setOption: #implementorToInline
			toUse: [ :ref :classes | classes detect: [ :each | each realClass = implementorClass ] ifNone: [ nil ] ];
		setOption: #inlineExpression toUse: [ :ref :msg | false ].
	^ refactoring
]

{ #category : #accessing }
GtSnippetInlineMessageRefactoringController >> refactoringName [
	^ 'Inline message send ' , messageNode selector
]

{ #category : #executing }
GtSnippetInlineMessageRefactoringController >> removeReturn: model [
	| cls ast |
	cls := model classFor: self snippetClass.
	ast := (cls methodFor: self snippetSelector) ast.
	(ast body statements notEmpty and: [ ast body statements last isReturn ])
		ifFalse: [ ^ self ].
	ast body statements last replaceWith: ast body statements last value copy.
	cls compile: ast formattedCode classified: #accessing
]

{ #category : #executing }
GtSnippetInlineMessageRefactoringController >> safelyExecute [
	| refactoring |
	refactoring := self refactoring.
	[ refactoring primitiveExecute.
	returnLocation ifNotNil: [ self removeReturn: refactoring model ] ]
		on: RBRefactoringError
		do: [ :ex | ^ self inform: ex messageText ].
	self setText: (self refactoredSnippetCodeFrom: refactoring)
]

{ #category : #private }
GtSnippetInlineMessageRefactoringController >> setterSelectorFor: aString in: aRBClass [
	^ (aRBClass setterMethodFor: aString)
		ifNil: [ aRBClass superclass
				ifNotNil: [ :spr | 
					(spr definesInstanceVariable: aString)
						ifTrue: [ self setterSelectorFor: aString in: spr ] ] ]
]

{ #category : #private }
GtSnippetInlineMessageRefactoringController >> setterSendFor: aString to: aNode in: aRBClass [
	^ (setterSelectors
		at: aString
		ifAbsentPut: [ self setterSelectorFor: aString in: aRBClass ])
		ifNotNil: [ :selector | 
			RBMessageNode
				receiver: (RBVariableNode named: 'self')
				selector: selector
				arguments: {aNode value copy} ]
]

{ #category : #accessing }
GtSnippetInlineMessageRefactoringController >> snippetClass [
	^ snippetClass ifNil: [ implementorClass ]
]

{ #category : #accessing }
GtSnippetInlineMessageRefactoringController >> snippetClass: aClass [
	snippetClass := aClass
]

{ #category : #private }
GtSnippetInlineMessageRefactoringController >> updateVariableReferencesIn: model [
	| cls method ast rewriter |
	(self snippetClass includesBehavior: implementorClass) ifTrue: [ ^ self ].
	cls := model classFor: implementorClass.
	method := cls methodFor: messageNode selector.
	ast := method ast.
	rewriter := RBParseTreeRewriter new.
	implementorClass allInstVarNames
		do: [ :each | 
			rewriter
				replace: each , ' := ``@a'
					withValueFrom: [ :node | 
						(self
							setterSendFor: each
							to: node value
							in: cls) ifNil: [ node copy ] ];
				replace: each
					withValueFrom: [ :node | (self getterSendFor: each in: cls) ifNil: [ node copy ] ] ].
	rewriter executeTree: ast.
	cls compile: ast formattedCode
]
