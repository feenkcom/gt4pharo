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
