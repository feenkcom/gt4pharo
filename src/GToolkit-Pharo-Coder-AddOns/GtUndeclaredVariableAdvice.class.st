Class {
	#name : #GtUndeclaredVariableAdvice,
	#superclass : #GtMethodAdvice,
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #testing }
GtUndeclaredVariableAdvice >> canAddInstanceVariable: aString to: aClass [
	(Object includesBehavior: aClass) ifTrue: [ ^ false ].
	^ [ (GtRBAddInstanceVariableRefactoring variable: aString class: aClass)
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
		ifTrue: [ theFixitActions
				add: (GtDefineParserFixItAction forCoder: coderModel node: aVariableNode) ].

	coderModel class = GtPharoSnippetCoder
		ifFalse: [ | aDefineClassAction |
			aDefineClassAction := GtDefineClassVariableFixItAction
					forCoder: coderModel
					node: aVariableNode.
			theFixitActions add: aDefineClassAction ].

	results := OrderedCollection
			withAll: (self localNamesFor: aVariableNode coderModel: coderModel).
	results addAll: (self globalNamesFor: aVariableNode coderModel: coderModel).

	theFixitActions
		addAll: (results
				collect: [ :each | 
					(GtRenameVariableFixItAction forCoder: coderModel node: aVariableNode)
						newName: each ]).

	^ theFixitActions
]

{ #category : #styling }
GtUndeclaredVariableAdvice >> globalNamesFor: aVariableNode coderModel: coderModel [
	| items word min nameBlock cls |
	items := Array new: 5 withAll: '' -> -1.
	word := aVariableNode variableName.
	min := word size / 2.0.
	nameBlock := [ :each | 
		| value |
		((value := word alike: each) >= min
			and: [ (each alike: word) >= (each size / 2.0) ])
			ifTrue: [ | index |
				index := items size.
				[ index > 0 and: [ (items at: index) value < value ] ]
					whileTrue: [ index = items size
							ifTrue: [ items at: index put: each -> value ]
							ifFalse: [ items swap: index with: index + 1 ].
						index := index - 1 ] ] ].

	cls := coderModel behavior ifNotNil: [ :each | each instanceSide ].
	[ cls notNil ]
		whileTrue: [ cls classPool keysDo: nameBlock.
			cls sharedPools do: [ :pool | pool keysDo: nameBlock ].
			cls := cls superclass ].

	Smalltalk globals keysDo: nameBlock.
	^ (items reject: [ :each | each value < 0 ]) collect: #key
]

{ #category : #styling }
GtUndeclaredVariableAdvice >> localFixItActionsFor: aVariableNode coderModel: coderModel [
	| theFixitActions localItems |
	theFixitActions := OrderedCollection new.
	theFixitActions
		add: (GtDefineTemporaryFixItAction forCoder: coderModel node: aVariableNode).
	(self
		canAddInstanceVariable: aVariableNode variableName
		to: coderModel behavior)
		ifTrue: [ theFixitActions
				add: (GtDefineInstanceVariableFixItAction forCoder: coderModel node: aVariableNode) ].
	localItems := self localNamesFor: aVariableNode coderModel: coderModel.
	theFixitActions
		addAll: (localItems
				collect: [ :each | 
					(GtRenameVariableFixItAction forCoder: coderModel node: aVariableNode)
						newName: each ]).
	^ theFixitActions
]

{ #category : #styling }
GtUndeclaredVariableAdvice >> localNamesFor: aVariableNode coderModel: coderModel [
	| possibleNames |
	possibleNames := aVariableNode localVariables
			, coderModel behavior allInstVarNames.
	^ self findPotentialMatchesFor: aVariableNode in: possibleNames
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
