Class {
	#name : #GtPharoCompletionStrategy,
	#superclass : #GtStreamedCompletionStrategy,
	#instVars : [
		'class',
		'isMethod',
		'wasRequested',
		'hasImplicitVariables',
		'methodPattern',
		'variables',
		'localVariables',
		'index',
		'pragmas',
		'bindings',
		'selfObject'
	],
	#classVars : [
		'GlobalCache',
		'SelectorCache'
	],
	#category : #'GToolkit-Pharo-Completer-Completion'
}

{ #category : #'instance creation' }
GtPharoCompletionStrategy class >> newForExpression [
	^ self new
		isMethod: false;
		yourself
]

{ #category : #'instance creation' }
GtPharoCompletionStrategy class >> newForMethod [
	^ self new
		isMethod: true;
		yourself
]

{ #category : #'instance creation' }
GtPharoCompletionStrategy class >> newForSnippet [
	^ self new
		isMethod: false;
		hasImplicitVariables: true;
		yourself
]

{ #category : #'private-variables' }
GtPharoCompletionStrategy >> addBindingsTo: variableNames [
	bindings ifNotNil: [ variableNames addAll: bindings bindingNames ]
]

{ #category : #accessing }
GtPharoCompletionStrategy >> bindings [
	^ bindings
]

{ #category : #accessing }
GtPharoCompletionStrategy >> bindings: anObject [
	bindings := anObject
]

{ #category : #accessing }
GtPharoCompletionStrategy >> classOrMetaClass [
	^ class
]

{ #category : #accessing }
GtPharoCompletionStrategy >> classOrMetaClass: aClass [
	class := aClass
]

{ #category : #accessing }
GtPharoCompletionStrategy >> completionActionStreamFor: aText at: positionInteger requested: aBoolean [
	index := positionInteger.
	wasRequested := aBoolean.
	^ (self parseSource: aText asString) ifNil: [ #() asAsyncStream ] ifNotNil: [ :tree | tree completionActionStreamFor: self ]
]

{ #category : #accessing }
GtPharoCompletionStrategy >> forMethod: aCompiledMethod [
	| source ast |
	self classOrMetaClass: aCompiledMethod methodClass.
	source := aCompiledMethod sourceCode.
	ast := GtPharoParser parse: source.
	self methodPattern: ast pattern
]

{ #category : #ui }
GtPharoCompletionStrategy >> gtItemsFor: aView [
	<gtView>
	^ self variables 
		ifNil:  [ ^ aView ]
		ifNotNil: [ self variables gtItemsFor: aView ]
]

{ #category : #ui }
GtPharoCompletionStrategy >> gtViewChildrenFor: aView [
	<gtView>
	^ self variables 
		ifNil:  [ ^ aView empty ]
		ifNotNil: [ self variables gtItemsFor: aView ]
]

{ #category : #testing }
GtPharoCompletionStrategy >> hasCompletionsAt: anInteger in: aText [
	| char |
	(anInteger < 1 or: [ anInteger > aText size ]) ifTrue: [ ^ false ].
	char := aText at: anInteger.
	^ char isLetter or: [ char isDigit ]
]

{ #category : #accessing }
GtPharoCompletionStrategy >> hasImplicitVariables [
	^ hasImplicitVariables
]

{ #category : #accessing }
GtPharoCompletionStrategy >> hasImplicitVariables: aBoolean [
	hasImplicitVariables := aBoolean
]

{ #category : #'private-method' }
GtPharoCompletionStrategy >> hierarchyMethodsStartingWith: aString [
	| methods |
	class isNil
		ifTrue: [ ^ #() ].
	methods := OrderedCollection new.
	class
		allSuperclassesDo: [ :each | methods addAll: ((each selectors select: [ :sel | sel beginsWith: aString ]) asSortedCollection collect: [ :sel | each >> sel ]) ].
	class
		allSubclassesDo: [ :each | methods addAll: ((each selectors select: [ :sel | sel beginsWith: aString ]) asSortedCollection collect: [ :sel | each >> sel ]) ].
	^ methods
]

{ #category : #accessing }
GtPharoCompletionStrategy >> index [
	^ index
]

{ #category : #'initialize-release' }
GtPharoCompletionStrategy >> initialize [
	super initialize.
	isMethod := true.
	hasImplicitVariables := false.
	localVariables := GtPrefixTree
		withAll: #('self' 'true' 'false' 'nil' 'thisContext').
	variables := GtCompositePrefixTree
		trees:
			{GtPharoIndex current globalCache.
			localVariables}
]

{ #category : #testing }
GtPharoCompletionStrategy >> isCamelCaseSubsequence: subString of: completeString [
	| indices current |
	indices := self subsequenceIndices: subString of: completeString.
	indices size = subString size ifFalse: [ ^ false ].
	current := 1.
	subString
		with: indices
		do:
			[ :char :i | 
			(i = current or: [ char isUppercase or: [ i > 1 and: [ (completeString at: i - 1) = $: ] ] ]) ifFalse: [ ^ false ].
			current := i + 1 ].
	^ true
]

{ #category : #'initialize-release' }
GtPharoCompletionStrategy >> isMethod: aBoolean [
	isMethod := aBoolean
]

{ #category : #'private-variables' }
GtPharoCompletionStrategy >> localVariablesFor: aVariableNode [
	| vars |
	self hasImplicitVariables ifFalse: [ ^ aVariableNode localVariables ].
	vars := aVariableNode implicitLocalVariables.
	self addBindingsTo: vars.
	^ vars
]

{ #category : #accessing }
GtPharoCompletionStrategy >> methodPattern: aMethodPattern [
	methodPattern := aMethodPattern.
	methodPattern notNil
		ifTrue: [ methodPattern variables
				do: [ :each | localVariables add: each variableName ] ].
	self isMethod: false
]

{ #category : #private }
GtPharoCompletionStrategy >> parseSource: aString [
	^ [ isMethod
		ifTrue: [ GtPharoParser parseWithErrors: aString ]
		ifFalse: [ GtPharoParser parseWithErrors: aString startingAt: GtPharoParser startingStateForMethodSequence ] ]
		on: SmaCCParserError
		do: [ :ex | ex return: nil ]
]

{ #category : #'private-pragmas' }
GtPharoCompletionStrategy >> pragmas [
	pragmas isNil
		ifTrue: [ pragmas := GtPrefixTree new.
			Pragma pragmaCache
				keysAndValuesDo: [ :key :value | pragmas add: key weight: value size ] ].
	^ pragmas
]

{ #category : #'private-pragmas' }
GtPharoCompletionStrategy >> pragmas: anInteger startingWith: aString [
	^ self pragmas weightedFirst: anInteger startingWith: aString
]

{ #category : #'private-selector' }
GtPharoCompletionStrategy >> selectorStreamForReceiver: aBehavior matching: aString [
	^ self
		selectorStreamForReceiver: aBehavior
		matching: aString
		alphabetical: false
		includeAllKeywords: false
]

{ #category : #'private-selector' }
GtPharoCompletionStrategy >> selectorStreamForReceiver: aBehavior matching: aString alphabetical: aBoolean includeAllKeywords: keywords [
	| tree stream selectors |
	tree := GtPharoIndex current selectorCache.
	stream := aBoolean
			ifTrue: [ tree asyncStreamStartingWith: aString ]
			ifFalse: [ tree asyncWeightedStreamStartingWith: aString ].
	^ aBehavior
		ifNil: [ stream ]
		ifNotNil: [ selectors := GtPrefixTree withAll: aBehavior allSelectors.
			stream
				select: [ :each | (keywords and: [ each last = $: ]) or: [ selectors includes: each ] ] ]
]

{ #category : #'private-selector' }
GtPharoCompletionStrategy >> selectorStreamForReceiver: aBehavior matchingWords: aString [
	^ (GtPharoIndex current asyncSelectorsForWord: aString)
		select: [ :each | 
			(each beginsWith: aString) not
				and: [ aBehavior isNil
						ifTrue: [ GtPharoIndex current hasImplementersOf: each ]
						ifFalse: [ (aBehavior whichClassIncludesSelector: each asSymbol) notNil ] ] ]
]

{ #category : #accessing }
GtPharoCompletionStrategy >> selfObject [
	^ selfObject
]

{ #category : #accessing }
GtPharoCompletionStrategy >> selfObject: anObject [
	selfObject := anObject
]

{ #category : #'private-method' }
GtPharoCompletionStrategy >> signatureFor: aMethod [
	| source ast |
	source := aMethod sourceCode.
	ast := GtPharoParser parse: source.
	^ source
		copyFrom: ast selectorParts first startPosition
		to:
			(ast variables isEmpty
				ifTrue: [ ast selectorParts ]
				ifFalse: [ ast variables ]) last stopPosition
]

{ #category : #typing }
GtPharoCompletionStrategy >> typeOfVariable: aNode [
	| name |
	name := aNode name value.
	name = 'self' ifTrue: [ ^ self classOrMetaClass ].
	name = 'super' ifTrue: [ ^ self classOrMetaClass superclass ].
	self classOrMetaClass notNil
		ifTrue: [ (self classOrMetaClass bindingOf: name asSymbol)
				ifNotNil: [ :binding | binding value ifNotNil: [ :value | ^ value class ] ] ].
	bindings notNil
		ifTrue: [ (bindings hasBindingOf: name asSymbol)
				ifTrue: [ (bindings bindingOf: name asSymbol)
						ifNotNil: [ :binding | binding value ifNotNil: [ :value | ^ value class ] ] ] ].
	self selfObject class
		slotNamed: name
		ifFound: [ :slot | ^ (slot read: self selfObject) ifNotNil: [ :obj | obj class ] ].
	(Pragma allNamed: #gtVariableType)
		do: [ :each | 
			each method methodClass isClassSide
				ifTrue: [ (each method methodClass instanceSide
						perform: each method selector
						withArguments: {aNode}) ifNotNil: [ :cls | ^ cls ] ] ].
	^ nil
]

{ #category : #private }
GtPharoCompletionStrategy >> variableCompletionActionStreamFor: anAST [
	| allLocalVariables |
	allLocalVariables := self localVariablesFor: anAST.
	^ ((allLocalVariables asyncStreamStartingWith: '') merge: (self variables asyncStreamStartingWith: ''))
		collect:
			[ :each | 
			GtInsertTextCompletionAction
				labeled: each asRopedText glamorousCodeFont
				completion: each
				position: self index ]
]

{ #category : #accessing }
GtPharoCompletionStrategy >> variables [
	^ class
		ifNil: [ variables ]
		ifNotNil: [ GtCompositePrefixTree
				trees: {self variablesForClass.
						variables} ]
]

{ #category : #accessing }
GtPharoCompletionStrategy >> variablesForClass [
	| vars |
	vars := GtPrefixTree new.
	class
		ifNotNil: [ vars addAll: class allInstVarNames.
			vars addAll: class instanceSide allClassVarNames.
			class superclass ifNotNil: [ vars add: 'super' ] ].
	^ vars
]

{ #category : #testing }
GtPharoCompletionStrategy >> wasRequested [
	^ wasRequested
]
