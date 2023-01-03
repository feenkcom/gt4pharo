Class {
	#name : #GtSnippetInlineMessageRefactoringController,
	#superclass : #GtPharoSourceCoderRefactoringController,
	#instVars : [
		'messageNode',
		'implementorClass'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #accessing }
GtSnippetInlineMessageRefactoringController >> implementorClass: aClass [
	implementorClass := aClass
]

{ #category : #accessing }
GtSnippetInlineMessageRefactoringController >> messageNode: aGtPharoMessageSendNode [
	messageNode := aGtPharoMessageSendNode
]

{ #category : #accessing }
GtSnippetInlineMessageRefactoringController >> refactoring [
	| model refactoring |
	model := self createSnippetRefactoringModel.
	refactoring := RBInlineMethodFromComponentRefactoring
			model: model
			inline: (self snippetIntervalFor: messageNode sourceInterval)
			inMethod: self snippetSelector
			forClass: self snippetClass.
	refactoring options
		at: #implementorToInline
			put: [ :ref :classes | classes detect: [ :each | each realClass = implementorClass ] ifNone: [ nil ] ];
		at: #inlineExpression put: [ :ref :msg | false ].
	^ refactoring
]

{ #category : #accessing }
GtSnippetInlineMessageRefactoringController >> refactoringName [
	^ 'Inline message send ' , messageNode selector
]

{ #category : #executing }
GtSnippetInlineMessageRefactoringController >> safelyExecute [
	| refactoring |
	refactoring := self refactoring.
	[ refactoring primitiveExecute ] on: RBRefactoringError do: [ :ex | ^ self ].
	self setText: (self refactoredSnippetCodeFrom: refactoring)
]

{ #category : #private }
GtSnippetInlineMessageRefactoringController >> updateVariableReferencesIn: model [
	| cls method ast rewriter |
	cls := model classFor: implementorClass.
	method := cls methodFor: messageNode selector.
	ast := method ast.
	rewriter := RBParseTreeRewriter new.
	implementorClass allInstVarNames
		do:
			[ :each | 
			rewriter
				replace: each , ' := ``@a' with: 'self instVarNamed: ''' , each , ''' put: ``@a';
				replace: each with: 'self instVarNamed: ''' , each , '''' ].
	rewriter executeTree: ast.
	cls compile: ast formattedCode
]
