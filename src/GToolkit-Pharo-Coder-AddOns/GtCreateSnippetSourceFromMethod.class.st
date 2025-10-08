Class {
	#name : #GtCreateSnippetSourceFromMethod,
	#superclass : #Object,
	#instVars : [
		'method',
		'inlineSelfSends',
		'selectorsNotToInline',
		'assertSelectors'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #accessing }
GtCreateSnippetSourceFromMethod >> assertSelectors [
	^ assertSelectors
]

{ #category : #accessing }
GtCreateSnippetSourceFromMethod >> assertSelectors: anObject [
	assertSelectors := anObject
]

{ #category : #generating }
GtCreateSnippetSourceFromMethod >> astWithInlinedSelfSends [
	| refactoring ignoredSelectors |
	inlineSelfSends ifFalse: [ ^ method ast copy ].
	refactoring := GtInlineAllSelfSendsRefactoring
			selector: method selector
			class: method methodClass.
	refactoring setOption: #inlineExpression toUse: [ :ref :string | false ].
	ignoredSelectors := Set withAll: assertSelectors.
	ignoredSelectors addAll: selectorsNotToInline.
	refactoring ignoreSelectors: ignoredSelectors.
	[ refactoring primitiveExecute ] on: Error do: [ :ex | ex return ].
	^ refactoring ast
]

{ #category : #generating }
GtCreateSnippetSourceFromMethod >> fixAssertSendsIn: anAST [
	| rewriter ast |
	ast := RBParser parseExpression: (self snippetSourceFrom: anAST body).
	rewriter := RBParseTreeRewriter new.
	assertSelectors
		do: [ :sel | 
			| msg |
			msg := String
					streamContents: [ :stream | 
						sel keywords
							doWithIndex: [ :key :i | stream << ' ' << key << ' ``@a' << i printString ] ].
			rewriter replace: '``@r' , msg with: 'self' , msg ].
	(rewriter executeTree: ast) ifTrue: [ ast := rewriter tree ].
	^ ast
]

{ #category : #generating }
GtCreateSnippetSourceFromMethod >> generate [
	| ast |
	ast := self fixAssertSendsIn: self astWithInlinedSelfSends.
	^ ast formattedCode
]

{ #category : #initialization }
GtCreateSnippetSourceFromMethod >> initialize [
	super initialize.
	assertSelectors := #(#assert: #assert:description: #assert:equals:).
	selectorsNotToInline := #(#new #basicNew #new: #basicNew:).
	inlineSelfSends := true
]

{ #category : #accessing }
GtCreateSnippetSourceFromMethod >> inlineSelfSends [
	^ inlineSelfSends
]

{ #category : #accessing }
GtCreateSnippetSourceFromMethod >> inlineSelfSends: anObject [
	inlineSelfSends := anObject
]

{ #category : #generating }
GtCreateSnippetSourceFromMethod >> instanceClassName [
	^ method methodClass instanceSide name
]

{ #category : #generating }
GtCreateSnippetSourceFromMethod >> isForMetaclass [
	^ method methodClass isClassSide
]

{ #category : #accessing }
GtCreateSnippetSourceFromMethod >> method [
	^ method
]

{ #category : #accessing }
GtCreateSnippetSourceFromMethod >> method: anObject [
	method := anObject
]

{ #category : #accessing }
GtCreateSnippetSourceFromMethod >> selectorsNotToInline [
	^ selectorsNotToInline
]

{ #category : #accessing }
GtCreateSnippetSourceFromMethod >> selectorsNotToInline: anObject [
	selectorsNotToInline := anObject
]

{ #category : #generating }
GtCreateSnippetSourceFromMethod >> snippetSourceFrom: anAST [
	| ast |
	ast := self updateInstanceVariableReferencesIn: anAST.
	ast := self updateSelfReferencesIn: ast.
	ast temporaryNames do: [ :each | ast removeTemporaryNamed: each ].
	(ast statements notEmpty and: [ ast statements last isReturn ]) 
		ifTrue: [ 
			ast
				replaceNode: ast statements last
				withNode: ast statements last value ].
	^ ast formattedCode
]

{ #category : #generating }
GtCreateSnippetSourceFromMethod >> updateInstanceVariableReferencesIn: anAST [
	| rewrites |
	rewrites := RBParseTreeRewriter new.
	method methodClass allInstVarNames
		do:
			[ :each | 
			rewrites
				replace: each , ' := ``@a' with: 'self instVarNamed: ''' , each , ''' put: ``@a';
				replace: each with: 'self instVarNamed: ''' , each , '''' ].
	rewrites executeTree: anAST.
	^ rewrites tree
]

{ #category : #generating }
GtCreateSnippetSourceFromMethod >> updateSelfReferencesIn: anAST [
	| selfNodes newNode |
	selfNodes := OrderedCollection new.
	anAST
		nodesDo: [ :each | (each isVariable and: [ each name = #self ]) ifTrue: [ selfNodes add: each ] ].
	selfNodes isEmpty ifTrue: [ ^ anAST ].
	self isForMetaclass
		ifTrue: [ newNode := RBVariableNode named: self instanceClassName ]
		ifFalse: [ selfNodes size > 1
				ifTrue: [ | name index |
					name := 'instance'.
					index := 1.
					[ anAST allTemporaryVariables anySatisfy: [ :each | each asString = name ] ]
						whileTrue: [ name := 'instance' , index printString.
							index := index + 1 ].
					anAST
						addNodeFirst: (RBAssignmentNode
								variable: (RBVariableNode named: name)
								value: (RBMessageNode
										receiver: (RBVariableNode named: self instanceClassName)
										selector: #new)).
					newNode := RBVariableNode named: name ]
				ifFalse: [ newNode := RBMessageNode
							receiver: (RBVariableNode named: self instanceClassName)
							selector: #new ] ].
	selfNodes do: [ :each | each replaceWith: newNode copy ].
	^ anAST
]
