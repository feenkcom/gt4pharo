Class {
	#name : #GtMethodAdviceStyler,
	#superclass : #GtGenericPharoStyler,
	#traits : 'TMethodAdviceRunner',
	#classTraits : 'TMethodAdviceRunner classTrait',
	#instVars : [
		'critics',
		'isForWorkspace',
		'hasRefactoring',
		'variableBindings',
		'isDoIt'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #comparing }
GtMethodAdviceStyler >> = anObject [
	^ self class = anObject class
		and: [ self isForWorkspace = anObject isForWorkspace
				and: [ self variableBindings == anObject variableBindings
						and: [ self critics = anObject critics ] ] ]
]

{ #category : #visiting }
GtMethodAdviceStyler >> acceptNode: aSmaCCParseNode [
	critics
		do: [ :each | 
			(each matches: aSmaCCParseNode from: self)
				ifTrue: [ each styleIssue: aSmaCCParseNode using: self ] ].
	super acceptNode: aSmaCCParseNode.
	critics do: [ :each | each finish: aSmaCCParseNode from: self ]
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
GtMethodAdviceStyler >> critics [
	^ critics
]

{ #category : #accessing }
GtMethodAdviceStyler >> critics: aCollection [
	critics := aCollection
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
	critics := GtMethodAdvice activeCritics.
	isDoIt := false.
	isForWorkspace := false
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
GtMethodAdviceStyler >> sourceCoder [
	^ self coderViewModel coderModel
]

{ #category : #styling }
GtMethodAdviceStyler >> style: aText ast: theAst [
	hasRefactoring := nil.
	variableBindings := self coderViewModel compositeVariableBindings.
	[ super style: aText ast: theAst ]
		ensure: [ variableBindings := nil ]
]

{ #category : #accessing }
GtMethodAdviceStyler >> text [
	^ text
]

{ #category : #utility }
GtMethodAdviceStyler >> typeOf: aGtPharoProgramNode [
	^ GtPharoProgramNode
		typeOf: aGtPharoProgramNode
		in: (isForWorkspace
			ifTrue: [ self coderViewModel selfObject class ]
			ifFalse: [ self sourceCoder behavior ])
		bindings: variableBindings
]

{ #category : #accessing }
GtMethodAdviceStyler >> variableBindings [
	^ variableBindings
]
