Class {
	#name : #GtMethodCriticExampleRunner,
	#superclass : #Object,
	#traits : 'TCriticRunner',
	#classTraits : 'TCriticRunner classTrait',
	#instVars : [
		'critic',
		'method',
		'nodes'
	],
	#pools : [
		'TextConstants'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #'example method' }
GtMethodCriticExampleRunner class >> newExampleMethod [
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
GtMethodCriticExampleRunner >> andandExample [
	<gtExample>
	^ self
		compareResultsFrom: GtUnoptimizedConditionalCritic new
		source: 'a (self isLiteral and: [a isLiteral]) and: [b isLitera]'
		to: [ :ast :block | block value: ast body statements last ]
]

{ #category : #examples }
GtMethodCriticExampleRunner >> andorExample [
	<gtExample>
	^ self
		compareResultsFrom: GtUnoptimizedConditionalCritic new
		source: 'a (self isLiteral and: [a isLiteral]) or: [b isLitera]'
		to: [ :ast :block |  ]
]

{ #category : #examples }
GtMethodCriticExampleRunner >> assignmentNotNeededExample [
	<gtExample>
	^ self
		compareResultsFrom: GtAssignmentNotNeededCritic new
		source: 'a | a | ^ a := 3'
		to: [ :ast :block | block value: ast body statements first value ]
]

{ #category : #examples }
GtMethodCriticExampleRunner >> assignmentToSameVariableExample [
	<gtExample>
	^ self
		compareResultsFrom: GtRedundantAssignmentCritic new
		source: 'a: b critic := critic'
		to: [ :ast :block | block value: ast body statements last ]
]

{ #category : #accessing }
GtMethodCriticExampleRunner >> behavior [
	^ method methodClass
]

{ #category : #examples }
GtMethodCriticExampleRunner >> checkClassVarRefIsValid [
	<gtExample>
	^ self
		compareResultsFrom: GtUndeclaredVariableCritic new
		source: 'classVarReference ^ DependentsFields'
		to: [ :ast :block |  ]
]

{ #category : #examples }
GtMethodCriticExampleRunner >> checkPoolVarRefIsValid [
	<gtExample>
	^ self
		compareResultsFrom: GtUndeclaredVariableCritic new
		source: 'poolVariableReference ^ Tab'
		to: [ :ast :block |  ]
]

{ #category : #private }
GtMethodCriticExampleRunner >> compareResultsFrom: aCritic method: aCompiledMethod to: aBlock [
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
GtMethodCriticExampleRunner >> compareResultsFrom: aCritic source: aString to: aBlock [
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
GtMethodCriticExampleRunner >> duplicateCodeInCondition [
	<gtExample>
	^ self
		compareResultsFrom: GtDuplicateCodeInConditionalCritic new
		source: 'a self isLiteral ifTrue: [3] ifFalse: [4]. self isLiteral ifTrue: [self foo. self bar] ifFalse: [self foo]. self isLiteral ifTrue: [self foo. self bar] ifFalse: [self bar]'
		to: [ :ast :block | 
			block value: ast body statements second message.
			block value: ast body statements last message ]
]

{ #category : #examples }
GtMethodCriticExampleRunner >> equalsNotUsedExample [
	<gtExample>
	^ self
		compareResultsFrom: GtEqualsNotUsedCritic new
		source: 'a: b critic = b'
		to: [ :ast :block | block value: ast body statements last message ]
]

{ #category : #accessing }
GtMethodCriticExampleRunner >> foundIssue: aCritic in: aNode [
	nodes add: aNode
]

{ #category : #examples }
GtMethodCriticExampleRunner >> haltExample [
	<gtExample>
	^ self
		compareResultsFrom: GtHaltCritic new
		source: 'a self halt. Halt once'
		to: [ :ast :block | 
			block value: ast body statements first message.
			block value: ast body statements last ]
]

{ #category : #initialization }
GtMethodCriticExampleRunner >> initialize [
	super initialize.
	nodes := IdentitySet new
]

{ #category : #examples }
GtMethodCriticExampleRunner >> messagesNotImplementedExample [
	<gtExample>
	^ self
		compareResultsFrom: GtMessageNotImplementedCritic new
		method: self class class >> #newExampleMethod
		to: [ :ast :block | 
			ast body statements last value values
				keysAndValuesDo: [ :i :node | i > 2 ifTrue: [ block value: node message ] ] ]
]

{ #category : #examples }
GtMethodCriticExampleRunner >> ororExample [
	<gtExample>
	^ self
		compareResultsFrom: GtUnoptimizedConditionalCritic new
		source: 'a (self isLiteral or: [a isLiteral]) or: [b isLitera]'
		to: [ :ast :block | block value: ast body statements last ]
]

{ #category : #accessing }
GtMethodCriticExampleRunner >> processNode: aNode [
	(critic matches: aNode from: self) ifTrue: [ nodes add: aNode ].
	aNode nodesDo: [ :node | self processNode: node ].
	critic finish: aNode from: self
]

{ #category : #examples }
GtMethodCriticExampleRunner >> rejectNotUsedExample [
	<gtExample>
	^ self
		compareResultsFrom: GtCollectSelectNotUsedCritic new
		source: 'a (1 to: 10) reject: [:each | each isOdd]'
		to: [ :ast :block | block value: ast body statements last message ]
]

{ #category : #examples }
GtMethodCriticExampleRunner >> tempNotUsedExample [
	<gtExample>
	^ self
		compareResultsFrom: GtTemporaryNotUsedCritic new
		source: 'a | a b | a := 3. ^ a * 2'
		to: [ :ast :block | block value: ast body variables last ]
]

{ #category : #examples }
GtMethodCriticExampleRunner >> todoExample [
	<gtExample>
	^ self
		compareResultsFrom: GtUnoptimizedToDoCritic new
		source: 'a (1 to: 10) do: [ :i | Transcript print: i ]'
		to: [ :ast :block | block value: ast body statements last ]
]

{ #category : #examples }
GtMethodCriticExampleRunner >> undeclaredVariable [
	<gtExample>
	^ self
		compareResultsFrom: GtUndeclaredVariableCritic new
		source: 'a ^UndeclaredTab'
		to: [ :ast :block | block value: ast body statements last value ]
]

{ #category : #examples }
GtMethodCriticExampleRunner >> valueNotUsedExample [
	<gtExample>
	^ self
		compareResultsFrom: GtValueNotUsedCritic new
		source: 'a #()'
		to: [ :ast :block | block value: ast body statements last ]
]

{ #category : #examples }
GtMethodCriticExampleRunner >> yourselfNotUsedExample [
	<gtExample>
	^ self
		compareResultsFrom: GtYourselfNotUsedCritic new
		source: 'a Transcript print: 1; yourself'
		to: [ :ast :block | block value: ast body statements last messages last ]
]
