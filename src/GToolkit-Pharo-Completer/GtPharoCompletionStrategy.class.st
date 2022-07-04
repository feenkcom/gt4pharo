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
		'variableTypes',
		'bindings'
	],
	#classVars : [
		'GlobalCache',
		'SelectorCache'
	],
	#category : #'GToolkit-Pharo-Completer-Completion'
}

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
GtPharoCompletionStrategy >> blockVariables: aDictionary [
	variableTypes := Dictionary new.
	aDictionary
		keysAndValuesDo: [ :name :cls | 
			localVariables add: name.
			variableTypes at: name put: cls ].
	self isMethod: false
]

{ #category : #accessing }
GtPharoCompletionStrategy >> classOrMetaClass [
	^ class
]

{ #category : #accessing }
GtPharoCompletionStrategy >> classOrMetaClass: aClass [
	class := aClass.
	class notNil
		ifTrue: [ localVariables addAll: class allInstVarNames.
			class isMeta
				ifTrue: [ localVariables addAll: class instanceSide allClassVarNames ]
				ifFalse: [ localVariables addAll: class allClassVarNames ].
			class superclass notNil
				ifTrue: [ localVariables add: 'super' ] ]
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
	anInteger < 1
		ifTrue: [ ^ false ].
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
			GtPharoSystemTraverser default
				allClassesAndTraitsDo: [ :each | 
					[ :cls | cls selectors do: [ :sel | (cls >> sel) pragmas do: [ :pragma | pragmas add: pragma selector ] ] ]
						value: each;
						value: each class ] ].
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
]

{ #category : #'private-selector' }
GtPharoCompletionStrategy >> selectorStreamForReceiver: aBehavior matching: aString alphabetical: aBoolean [
	| tree |
	tree := aBehavior notNil
			ifTrue: [ GtPrefixTree withAll: aBehavior allSelectors ]
			ifFalse: [ GtPharoIndex current selectorCache ].
	^ aBoolean
		ifTrue: [ tree asyncStreamStartingWith: aString ]
		ifFalse: [ tree asyncWeightedStreamStartingWith: aString ]
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
GtPharoCompletionStrategy >> typeOfVariable: aString [
	aString = 'self' ifTrue: [ ^ self classOrMetaClass ].
	aString = 'super' ifTrue: [ ^ self classOrMetaClass superclass ].
	self classOrMetaClass notNil
		ifTrue:
			[ (self classOrMetaClass bindingOf: aString asSymbol)
				ifNotNil: [ :binding | binding value ifNotNil: [ :value | ^ value class ] ] ].
	bindings notNil
		ifTrue:
			[ (bindings bindingOf: aString asSymbol) ifNotNil: [ :binding | binding value ifNotNil: [ :value | ^ value class ] ] ].
	variableTypes notNil ifTrue: [ (variableTypes at: aString ifAbsent: [ nil ]) ifNotNil: [ :cls | ^ cls ] ].
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
				labeled: each
				completion: each
				position: self index ]
]

{ #category : #accessing }
GtPharoCompletionStrategy >> variables [
	^ variables
]

{ #category : #testing }
GtPharoCompletionStrategy >> wasRequested [
	^ wasRequested
]
