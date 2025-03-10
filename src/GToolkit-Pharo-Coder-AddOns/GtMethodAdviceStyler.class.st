Class {
	#name : #GtMethodAdviceStyler,
	#superclass : #GtGenericPharoStyler,
	#traits : 'TMethodAdviceRunner',
	#classTraits : 'TMethodAdviceRunner classTrait',
	#instVars : [
		'isForWorkspace',
		'hasRefactoring',
		'variableBindings',
		'isDoIt',
		'advices',
		'lastIndex'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #comparing }
GtMethodAdviceStyler >> = anObject [
	^ self class = anObject class
		and: [ self isForWorkspace = anObject isForWorkspace
				and: [ self variableBindings == anObject variableBindings
						and: [ self advices = anObject advices ] ] ]
]

{ #category : #visiting }
GtMethodAdviceStyler >> acceptNode: aSmaCCParseNode [
	advices
		do: [ :each | 
			(each matches: aSmaCCParseNode from: self)
				ifTrue: [ each styleIssue: aSmaCCParseNode using: self ] ].
	super acceptNode: aSmaCCParseNode.
	advices do: [ :each | each finish: aSmaCCParseNode from: self ]
]

{ #category : #accessing }
GtMethodAdviceStyler >> advices [
	^ advices
]

{ #category : #accessing }
GtMethodAdviceStyler >> advices: aCollection [
	advices := aCollection
]

{ #category : #accessing }
GtMethodAdviceStyler >> behavior [
	^ self coderViewModel behavior
]

{ #category : #accessing }
GtMethodAdviceStyler >> coderModel [
	^ self coderViewModel coderModel
]

{ #category : #accessing }
GtMethodAdviceStyler >> foundIssue: aCritic in: aNode [
	aCritic styleIssue: aNode using: self
]

{ #category : #testing }
GtMethodAdviceStyler >> hasDeclaredVariableNamed: aString [
	^ self coderViewModel hasDeclaredVariableNamed: aString
]

{ #category : #testing }
GtMethodAdviceStyler >> hasRefactoring [
	^ hasRefactoring
		ifNil: [ hasRefactoring := text
					hasAttributeSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRefactoringChangesAttribute ] ]
]

{ #category : #accessing }
GtMethodAdviceStyler >> initialize [
	super initialize.
	advices := GtMethodAdvice activeCritics.
	isDoIt := false.
	isForWorkspace := false.
	lastIndex := 0.
]

{ #category : #accessing }
GtMethodAdviceStyler >> isForWorkspace [
	^ isForWorkspace
]

{ #category : #accessing }
GtMethodAdviceStyler >> isForWorkspace: aBoolean [
	isForWorkspace := aBoolean
]

{ #category : #accessing }
GtMethodAdviceStyler >> nextIndex [
	<return: #Integer>
	^ lastIndex := (lastIndex ifNil: [ 0 ]) + 1
]

{ #category : #styling }
GtMethodAdviceStyler >> style: aText ast: theAst [
	hasRefactoring := nil.
	lastIndex := 0.
	variableBindings := self coderViewModel compositeVariableBindings.
	[ super style: aText ast: theAst ]
		ensure: [ 
			variableBindings := nil. 
			lastIndex := 0 ]
]

{ #category : #accessing }
GtMethodAdviceStyler >> text [
	^ text
]

{ #category : #accessing }
GtMethodAdviceStyler >> textAttributesAt: anInteger [
	^ text attributesAt: anInteger
]

{ #category : #utility }
GtMethodAdviceStyler >> typeOf: aGtPharoProgramNode [
	^ GtPharoProgramNode
		typeOf: aGtPharoProgramNode
		in: (isForWorkspace
				ifTrue: [ self coderViewModel selfObject class ]
				ifFalse: [ self coderModel
						ifObject: [ :obj | obj class ]
						ifNone: [ self coderModel behavior ] ])
		bindings: (variableBindings
				ifNil: [ self coderViewModel compositeVariableBindings ])
]

{ #category : #accessing }
GtMethodAdviceStyler >> variableBindings [
	^ variableBindings
]
