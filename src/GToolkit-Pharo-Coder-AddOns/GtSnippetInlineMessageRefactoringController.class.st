Class {
	#name : #GtSnippetInlineMessageRefactoringController,
	#superclass : #GtPharoSourceCoderRefactoringController,
	#instVars : [
		'messageNode',
		'implementorClass'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #private }
GtSnippetInlineMessageRefactoringController >> createRefactoringModel [
	| model |
	model := RBClassModelFactory rbNamespace onEnvironment: RBBrowserEnvironment new.
	self compileSnippetMethodIn: model.
	self updateVariableReferencesIn: model.
	^ model
]

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
	model := self createRefactoringModel.
	refactoring := RBInlineMethodFromComponentRefactoring
		model: model
		inline:
			(messageNode startPosition + self snippetSelector size + 1 to: messageNode stopPosition + self snippetSelector size + 1)
		inMethod: self snippetSelector
		forClass: self snippetClass.
	(refactoring options)
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
	| refactoring ast |
	refactoring := self refactoring.
	[ refactoring primitiveExecute ] on: RBRefactoringError do: [ :ex | ^ self ].
	ast := ((refactoring model classFor: self snippetClass) methodFor: self snippetSelector) ast body.
	ast temporaryNames do: [ :each | ast removeTemporaryNamed: each ].
	self setText: ast formattedCode
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
