Class {
	#name : #GtUndeclaredVariableAdvice,
	#superclass : #GtMethodAdvice,
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #testing }
GtUndeclaredVariableAdvice >> canAddInstanceVariable: aString to: aClass [
	(Object includesBehavior: aClass) ifTrue: [ ^ false ].
	^ [ (RBAddInstanceVariableRefactoring variable: aString class: aClass)
		checkPreconditions.
	true ] on: RBRefactoringError do: [ :ex | ex return: false ]
]

{ #category : #accessing }
GtUndeclaredVariableAdvice >> description [
	^ 'Variable is undeclared.'
]

{ #category : #styling }
GtUndeclaredVariableAdvice >> findPotentialMatchesFor: aVariableNode in: possibleNames [
	| possible min name |
	name := aVariableNode variableName.
	min := name size / 2.0.
	possible := possibleNames
			collect: [ :each | 
				{each.
					name alike: each.
					each alike: name} ].
	possible := possible
			select: [ :each | each second >= min and: [ each first size / 2.0 < each third ] ].
	^ ((possible asSortedCollection: [ :a :b | a second > b second ])
		collect: #first) first: (5 min: possible size)
]

{ #category : #styling }
GtUndeclaredVariableAdvice >> fixItActionsForNode: aVariableNode coderModel: coderModel [
	^ aVariableNode variableName first isUppercase
		ifTrue: [ self globalFixItActionsFor: aVariableNode coderModel: coderModel ]
		ifFalse: [ self localFixItActionsFor: aVariableNode coderModel: coderModel ]
]

{ #category : #styling }
GtUndeclaredVariableAdvice >> globalFixItActionsFor: aVariableNode coderModel: coderModel [
	| theFixitActions results |
	theFixitActions := OrderedCollection new.
	theFixitActions
		add: (GtDefineClassFixItAction forCoder: coderModel node: aVariableNode).
	
	(aVariableNode name value endsWith: 'Parser' caseSensitive: true)
		ifTrue: [ 
			theFixitActions
				add: (GtDefineParserFixItAction forCoder: coderModel node: aVariableNode). ].

	coderModel class = GtPharoSnippetCoder
		ifFalse: [ | aDefineClassAction |
			aDefineClassAction := GtDefineClassVariableFixItAction
					forCoder: coderModel
					node: aVariableNode.
			theFixitActions add: aDefineClassAction ].

	results := aVariableNode variableName
			correctAgainst: aVariableNode localVariables
			continuedFrom: nil.

	results := coderModel behavior
			possibleVariablesFor: aVariableNode variableName
			continuedFrom: results.

	theFixitActions
		addAll: ((aVariableNode variableName correctAgainst: nil continuedFrom: results)
				collect: [ :each | 
					(GtRenameVariableFixItAction forCoder: coderModel node: aVariableNode)
						newName: each ]).

	^ theFixitActions
]

{ #category : #styling }
GtUndeclaredVariableAdvice >> localFixItActionsFor: aVariableNode coderModel: coderModel [
	| theFixitActions possibleNames |
	theFixitActions := OrderedCollection new.
	theFixitActions
		add: (GtDefineTemporaryFixItAction forCoder: coderModel node: aVariableNode).

	(self
		canAddInstanceVariable: aVariableNode variableName
		to: coderModel behavior)
		ifTrue: [ theFixitActions
				add: (GtDefineInstanceVariableFixItAction forCoder: coderModel node: aVariableNode) ].
	possibleNames := aVariableNode localVariables
			, coderModel behavior allInstVarNames.

	theFixitActions
		addAll: ((self findPotentialMatchesFor: aVariableNode in: possibleNames)
				collect: [ :each | 
					(GtRenameVariableFixItAction forCoder: coderModel node: aVariableNode)
						newName: each ]).

	^ theFixitActions
]

{ #category : #testing }
GtUndeclaredVariableAdvice >> matches: aNode from: aCriticRunner [
	| position |
	aNode isErrorNode ifTrue: [ ^ false ].
	aCriticRunner hasRefactoring ifTrue: [ ^ false ].
	position := aNode startPosition.
	(position < SmallInteger maxVal
		and: [ (aCriticRunner textAttributesAt: position)
				anySatisfy: [ :each | each isKindOf: GtCompletionPartAttribute ] ])
		ifTrue: [ ^ false ].
	aNode isVariable ifFalse: [ ^ false ].
	aNode isUndeclared ifFalse: [ ^ false ].
	(aCriticRunner hasDeclaredVariableNamed: aNode variableName)
		ifTrue: [ ^ false ].
	^ (aCriticRunner hasDeclaredGlobalNamed: aNode variableName) not
]

{ #category : #accessing }
GtUndeclaredVariableAdvice >> name [
	^ 'Reference to undeclared variable'
]
