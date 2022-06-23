Class {
	#name : #GtMethodCriticStyler,
	#superclass : #GtGenericPharoStyler,
	#traits : 'TCriticRunner',
	#classTraits : 'TCriticRunner classTrait',
	#instVars : [
		'critics',
		'isForWorkspace',
		'hasRefactoring',
		'variableBindings',
		'isDoIt'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #comparing }
GtMethodCriticStyler >> = anObject [
	^ self class = anObject class
		and: [ self isForWorkspace = anObject isForWorkspace
				and: [ self variableBindings == anObject variableBindings
						and: [ self critics = anObject critics ] ] ]
]

{ #category : #visiting }
GtMethodCriticStyler >> acceptNode: aSmaCCParseNode [
	critics
		do: [ :each | 
			(each matches: aSmaCCParseNode from: self)
				ifTrue: [ each styleIssue: aSmaCCParseNode using: self ] ].
	super acceptNode: aSmaCCParseNode.
	critics do: [ :each | each finish: aSmaCCParseNode from: self ]
]

{ #category : #accessing }
GtMethodCriticStyler >> behavior [
	^ self coderViewModel behavior
]

{ #category : #accessing }
GtMethodCriticStyler >> coderModel [
	^ self coderViewModel coderModel
]

{ #category : #accessing }
GtMethodCriticStyler >> critics [
	^ critics
]

{ #category : #accessing }
GtMethodCriticStyler >> critics: aCollection [
	critics := aCollection
]

{ #category : #accessing }
GtMethodCriticStyler >> foundIssue: aCritic in: aNode [
	aCritic styleIssue: aNode using: self
]

{ #category : #testing }
GtMethodCriticStyler >> hasDeclaredVariableNamed: aString [
	^ self coderViewModel hasDeclaredVariableNamed: aString
]

{ #category : #testing }
GtMethodCriticStyler >> hasRefactoring [
	^ hasRefactoring
		ifNil: [ hasRefactoring := text
					hasAttributeSuchThat: [ :eachAttribute | eachAttribute isKindOf: GtRefactoringChangesAttribute ] ]
]

{ #category : #accessing }
GtMethodCriticStyler >> initialize [
	super initialize.
	critics := GtMethodCritic activeCritics.
	isDoIt := false.
	isForWorkspace := false
]

{ #category : #accessing }
GtMethodCriticStyler >> isForWorkspace [
	^ isForWorkspace
]

{ #category : #accessing }
GtMethodCriticStyler >> isForWorkspace: aBoolean [
	isForWorkspace := aBoolean
]

{ #category : #accessing }
GtMethodCriticStyler >> sourceCoder [
	^ self coderViewModel coderModel
]

{ #category : #styling }
GtMethodCriticStyler >> style: aText ast: theAst [
	hasRefactoring := nil.
	variableBindings := self coderViewModel compositeVariableBindings.
	[ super style: aText ast: theAst ]
		ensure: [ variableBindings := nil ]
]

{ #category : #accessing }
GtMethodCriticStyler >> text [
	^ text
]

{ #category : #utility }
GtMethodCriticStyler >> typeOf: aGtPharoProgramNode [
	^ GtPharoProgramNode
		typeOf: aGtPharoProgramNode
		in: (isForWorkspace
			ifTrue: [ self coderViewModel selfObject class ]
			ifFalse: [ self sourceCoder behavior ])
		bindings: variableBindings
]

{ #category : #accessing }
GtMethodCriticStyler >> variableBindings [
	^ variableBindings
]
