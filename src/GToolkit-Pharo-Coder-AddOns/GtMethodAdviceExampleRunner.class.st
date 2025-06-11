Class {
	#name : #GtMethodAdviceExampleRunner,
	#superclass : #Object,
	#traits : 'TMethodAdviceRunner',
	#classTraits : 'TMethodAdviceRunner classTrait',
	#instVars : [
		'critic',
		'method',
		'nodes'
	],
	#pools : [
		'TextConstants'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #'example method' }
GtMethodAdviceExampleRunner class >> newExampleMethod [
	"Just here for some sample messages for examples"

	^ {super new behavior.
		self new behavior.
		"Items below here should not be implemented"
		Object new add: 1.
		self new add: 2.
		self add: 3.
		OrderedCollection add: 4}
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> andandExample [
	<gtExample>
	^ self
		compareResultsFrom: GtUnoptimizedConditionalAdvice new
		source: 'a (self isLiteral and: [a isLiteral]) and: [b isLitera]'
		to: [ :ast :block | block value: ast body statements last ]
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> andorExample [
	<gtExample>
	^ self
		compareResultsFrom: GtUnoptimizedConditionalAdvice new
		source: 'a (self isLiteral and: [a isLiteral]) or: [b isLitera]'
		to: [ :ast :block |  ]
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> assignmentNotNeededExample [
	<gtExample>
	^ self
		compareResultsFrom: GtAssignmentNotNeededAdvice new
		source: 'a | a | ^ a := 3'
		to: [ :ast :block | block value: ast body statements first value ]
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> assignmentToSameVariableExample [
	<gtExample>
	^ self
		compareResultsFrom: GtRedundantAssignmentAdvice new
		source: 'a: b critic := critic'
		to: [ :ast :block | block value: ast body statements last ]
]

{ #category : #accessing }
GtMethodAdviceExampleRunner >> behavior [
	^ method methodClass
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> checkClassVarRefIsValid [
	<gtExample>
	^ self
		compareResultsFrom: GtUndeclaredVariableAdvice new
		source: 'classVarReference ^ DependentsFields'
		to: [ :ast :block |  ]
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> checkPoolVarRefIsValid [
	<gtExample>
	^ self
		compareResultsFrom: GtUndeclaredVariableAdvice new
		source: 'poolVariableReference ^ Tab'
		to: [ :ast :block |  ]
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> coderMessagesNotImplementedExample [
	<gtExample>
	| coder |
	critic := GtMessageNotImplementedAdvice new.
	method := self class class >> #newExampleMethod.
	coder := GtPharoMethodCoder forMethod: method.
	^ self
		styleAndCompareResultsFrom: coder
		to: [ :ast :block | 
			ast body statements last value values
				keysAndValuesDo: [ :i :node | i > 2 ifTrue: [ block value: node message ] ] ]
		isWorkspace: false
]

{ #category : #private }
GtMethodAdviceExampleRunner >> compareResultsFrom: aCritic method: aCompiledMethod to: aBlock [
	| source ast foundNodes |
	critic := aCritic.
	method := aCompiledMethod.
	source := method sourceCode.
	ast := GtPharoParser parse: source.
	self processNode: ast.
	foundNodes := nodes copy.
	aBlock
		value: ast
		value: [ :found | 
			self assert: (foundNodes includes: found).

			foundNodes remove: found ].
	self assert: foundNodes isEmpty.
	^ nodes
]

{ #category : #private }
GtMethodAdviceExampleRunner >> compareResultsFrom: aCritic source: aString to: aBlock [
	| source ast foundNodes |
	critic := aCritic.
	method := thisContext method.
	source := aString.
	ast := GtPharoParser parse: source.
	self processNode: ast.
	foundNodes := nodes copy.
	aBlock
		value: ast
		value: [ :found | 
			self assert: (foundNodes includes: found).

			foundNodes remove: found ].
	self assert: foundNodes isEmpty.
	^ nodes
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> contextCoderMessagesNotImplementedExample [
	<gtExample>
	| coder context |
	critic := GtMessageNotImplementedAdvice new.
	method := 10 class compiler
			source: '
				self sqrt. 
				self notImplementedMessage	"This one is not implemented"';
			class: Integer;
			receiver: 10;
			isScripting: true;
			compile.
	context := Context
			sender: nil
			receiver: 10
			method: method
			arguments: #().
	coder := GtPharoMethodContextCoder forContext: context session: nil.
	^ self
		styleAndCompareResultsFrom: coder
		to: [ :ast :block | block value: ast body statements last message ]
		isWorkspace: false
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> contextCoderUndeclaredVariableExample [
	<gtExample>
	| coder context receiver |
	critic := GtUndeclaredVariableAdvice new.
	receiver := OrderedCollection new.
	method := receiver class compiler
			source: '
				firstIndex < lastIndex ifTrue: [firstIndex] ifFalse: [unknown]';
			class: Integer;
			receiver: receiver;
			isScripting: true;
			compile.
	context := Context
			sender: nil
			receiver: receiver
			method: method
			arguments: #().
	coder := GtPharoMethodContextCoder forContext: context session: nil.
	^ self
		styleAndCompareResultsFrom: coder
		to: [ :ast :block | 
			block
				value: ast body statements last message arguments last body statements last ]
		isWorkspace: false
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> duplicateCodeInCondition [
	<gtExample>
	^ self
		compareResultsFrom: GtDuplicateCodeInConditionalAdvice new
		source: 'a self isLiteral ifTrue: [3] ifFalse: [4]. self isLiteral ifTrue: [self foo. self bar] ifFalse: [self foo]. self isLiteral ifTrue: [self foo. self bar] ifFalse: [self bar]'
		to: [ :ast :block | 
			block value: ast body statements second message.
			block value: ast body statements last message ]
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> equalsNotUsedExample [
	<gtExample>
	^ self
		compareResultsFrom: GtEqualsNotUsedAdvice new
		source: 'a: b critic = b'
		to: [ :ast :block | block value: ast body statements last message ]
]

{ #category : #accessing }
GtMethodAdviceExampleRunner >> foundIssue: aCritic in: aNode [
	nodes add: aNode
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> haltExample [
	<gtExample>
	^ self
		compareResultsFrom: GtHaltAdvice new
		source: 'a self halt. Halt once'
		to: [ :ast :block | 
			block value: ast body statements first message.
			block value: ast body statements last ]
]

{ #category : #initialization }
GtMethodAdviceExampleRunner >> initialize [
	super initialize.
	nodes := IdentitySet new
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> messagesNotImplementedExample [
	<gtExample>
	^ self
		compareResultsFrom: GtMessageNotImplementedAdvice new
		method: self class class >> #newExampleMethod
		to: [ :ast :block | 
			ast body statements last value values
				keysAndValuesDo: [ :i :node | i > 2 ifTrue: [ block value: node message ] ] ]
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> ororExample [
	<gtExample>
	^ self
		compareResultsFrom: GtUnoptimizedConditionalAdvice new
		source: 'a (self isLiteral or: [a isLiteral]) or: [b isLitera]'
		to: [ :ast :block | block value: ast body statements last ]
]

{ #category : #accessing }
GtMethodAdviceExampleRunner >> processNode: aNode [
	(critic matches: aNode from: self) ifTrue: [ nodes add: aNode ].
	aNode nodesDo: [ :node | self processNode: node ].
	critic finish: aNode from: self
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> rejectNotUsedExample [
	<gtExample>
	^ self
		compareResultsFrom: GtCollectSelectNotUsedAdvice new
		source: 'a (1 to: 10) reject: [:each | each isOdd]'
		to: [ :ast :block | block value: ast body statements last message ]
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> snippetCoderMessagesNotImplementedExample [
	<gtExample>
	| coder |
	critic := GtMessageNotImplementedAdvice new.
	coder := GtPharoSnippetCoder
			forSource: '
				OrderedCollection new add: 1. 
				foo add: 2. 
				OrderedCollection add: 3 "This one is the only one that should be flagged"'.
	^ self
		styleAndCompareResultsFrom: coder
		to: [ :ast :block | block value: ast statements last message ]
		isWorkspace: true
]

{ #category : #private }
GtMethodAdviceExampleRunner >> styleAndCompareResultsFrom: coder to: aBlock isWorkspace: aBoolean [
	| ast foundNodes viewModel styler text |
	viewModel := coder asCoderViewModel.
	styler := GtMethodAdviceStyler new isForWorkspace: aBoolean.
	styler coderViewModel: viewModel.
	text := coder sourceCode currentSourceString string asRopedText.
	styler style: text.
	ast := coder ast wait ast.
	ast
		withAllNodesOfType: GtPharoMessageNode
		do: [ :node | 
			((text attributesAt: node selectorParts last stopPosition)
				anySatisfy: [ :attr | attr class = GtFixItAttribute ])
				ifTrue: [ nodes add: node ] ].
	ast
		withAllNodesOfType: GtPharoVariableNode
		do: [ :node | 
			((text attributesAt: node stopPosition)
				anySatisfy: [ :attr | attr class = GtFixItAttribute ])
				ifTrue: [ nodes add: node ] ].
	foundNodes := nodes copy.
	aBlock
		value: ast
		value: [ :found | 
			self assert: (foundNodes includes: found).

			foundNodes remove: found ].
	self assert: foundNodes isEmpty.
	^ text
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> tempNotUsedExample [
	<gtExample>
	^ self
		compareResultsFrom: GtTemporaryNotUsedAdvice new
		source: 'a | a b | a := 3. ^ a * 2'
		to: [ :ast :block | block value: ast body variables last ]
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> todoExample [
	<gtExample>
	^ self
		compareResultsFrom: GtUnoptimizedToDoAdvice new
		source: 'a (1 to: 10) do: [ :i | Transcript print: i ]'
		to: [ :ast :block | block value: ast body statements last ]
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> undeclaredVariable [
	<gtExample>
	^ self
		compareResultsFrom: GtUndeclaredVariableAdvice new
		source: 'a ^UndeclaredTab'
		to: [ :ast :block | block value: ast body statements last value ]
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> valueNotUsedExample [
	<gtExample>
	^ self
		compareResultsFrom: GtValueNotUsedAdvice new
		source: 'a #()'
		to: [ :ast :block | block value: ast body statements last ]
]

{ #category : #examples }
GtMethodAdviceExampleRunner >> yourselfNotUsedExample [
	<gtExample>
	^ self
		compareResultsFrom: GtYourselfNotUsedAdvice new
		source: 'a Transcript print: 1; yourself'
		to: [ :ast :block | block value: ast body statements last messages last ]
]
