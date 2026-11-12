"
Converts SUnit classes using the standard class refactoring lifecycle. model:from:to: defaults to an Object-based target using TAssertable. model:from:to:superclass: supplies an already converted superclass for inherited sources. Local fixture initialization and selector conversion follow the same policy in both cases; inherited fixture specialization is not inferred. Slot-read rewriting includes slots available through the target superclass. Private setup workspaces copy pending test ancestors so the existing inliner can resolve inherited behavior. Sources remain unchanged. primitiveExecute builds a preview in the supplied model; inherited execute applies changes. Converted tests use <after: #tearDown>. Cleanup slot reads use the generated the-prefixed getters; assignments remain slot writes. Inherited cleanup dispatch is preserved. Object-based roots supply an empty tearDown hook when the source has none, and calls to TestCase's empty super hook become no-ops. Local class-side methods are copied unchanged with their protocols, except isAbstract, which is omitted as SUnit-specific behavior.
"
Class {
	#name : #GtSUnitToExamplesRefactoring,
	#superclass : #RBClassRefactoring,
	#instVars : [
		'targetClassName',
		'targetSuperclassName'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #'instance creation' }
GtSUnitToExamplesRefactoring class >> model: aModel from: aClassName to: anExamplesClassName [
	^ self new
		initializeModel: aModel
		from: aClassName
		to: anExamplesClassName
]

{ #category : #'instance creation' }
GtSUnitToExamplesRefactoring class >> model: aModel from: sourceName to: targetName superclass: superclassName [
	^ (self
		model: aModel
		from: sourceName
		to: targetName)
		targetSuperclassName: superclassName;
		yourself
]

{ #category : #preconditions }
GtSUnitToExamplesRefactoring >> applicabilityPreconditions [
	| source conditions |
	source := self model classNamed: className.
	conditions := self sourcePreconditions.
	conditions add: (RBCondition isValidClassName: targetClassName).
	conditions
		add: ((RBCondition withBlock: [ (self model classNamed: targetClassName) isNil ])
				errorMacro: 'Target class already exists').
	source
		ifNotNil: [ conditions
				add: ((RBCondition
						withBlock: [ source superclass notNil
								and: [ source superclass name = #TestCase
										ifTrue: [ self targetSuperclassName = #Object ]
										ifFalse: [ self targetSuperclassName ~= #Object
												and: [ (source allSuperclasses anySatisfy: [ :each | each name = #TestCase ])
														and: [ (self model classNamed: self targetSuperclassName) notNil ] ] ] ] ])
						errorMacro: 'Specify the converted superclass for inherited test classes') ].
	^ self applicabilityPreconditionsFor: conditions
]

{ #category : #private }
GtSUnitToExamplesRefactoring >> collectSetupStatement: statement slots: slots initializers: initializers configurations: configurations [
	| assignment expression receiver |
	(statement isMessage
		and: [ statement receiver isVariable
				and: [ statement receiver isSuper and: [ statement selector = #setUp ] ] ])
		ifTrue: [ ^ self ].
	assignment := statement isAssignment
			and: [ slots includes: statement variable name ].
	receiver := self firstReceiverOf: statement.
	(assignment or: [ receiver isVariable and: [ slots includes: receiver name ] ])
		ifFalse: [ ^ self
				refactoringError: 'Expanded setUp must contain only direct slot assignments and super setUp' ].
	(assignment not and: [ (initializers includesKey: receiver name) not ])
		ifTrue: [ ^ self
				refactoringError: 'Setup configures a slot before its assignment: ' , receiver name ].
	expression := assignment ifTrue: [ statement value ] ifFalse: [ statement ].
	(expression containsReturn or: [ expression assignmentNodes notEmpty ])
		ifTrue: [ ^ self
				refactoringError: 'Setup returns and nested assignments require manual conversion' ].
	assignment
		ifTrue: [ ^ initializers
				at: statement variable name
				ifAbsentPut: [ statement value copy ] ].
	^ (configurations at: receiver name ifAbsentPut: [ OrderedCollection new ])
		add: statement copy
]

{ #category : #private }
GtSUnitToExamplesRefactoring >> exampleSelectorFor: selector [
	^ ((selector beginsWith: 'test')
		and: [ selector size > 4 and: [ selector numArgs = 0 ] ])
		ifTrue: [ (selector allButFirst: 4) uncapitalized asSymbol ]
		ifFalse: [ selector ]
]

{ #category : #private }
GtSUnitToExamplesRefactoring >> expandedSetupTreeFor: source slots: slots [
	"Expand standalone self sends so helper assignments participate in lazy initialization. Leave expression sends in their initializer."

	| setup send expansions |
	expansions := 0.
	setup := self setupTreeFor: source slots: slots.
	[ send := setup body statements
			detect: [ :statement | 
				statement isMessage
					and: [ statement receiver isVariable and: [ statement receiver name = 'self' ] ] ]
			ifNone: [ nil ].
	send notNil ]
		whileTrue: [ expansions := expansions + 1.
			expansions > 100
				ifTrue: [ self
						refactoringError: 'Setup helper expansion limit exceeded; check for recursion' ].
			(RBInlineMethodRefactoring
				model: source model
				inline: send sourceInterval
				inMethod: #setUp
				forClass: source) primitiveExecute.
			setup := self setupTreeFor: source slots: slots ].
	^ setup
]

{ #category : #private }
GtSUnitToExamplesRefactoring >> firstReceiverOf: statement [
	| receiver |
	receiver := statement.
	[ receiver isMessage or: [ receiver isCascade ] ]
		whileTrue: [ receiver := receiver receiver ].
	^ receiver
]

{ #category : #private }
GtSUnitToExamplesRefactoring >> getterSelectorForSlot: slot [
	^ ('the' , slot asString capitalized) asSymbol
]

{ #category : #printing }
GtSUnitToExamplesRefactoring >> gtDescription [
	^ 'Convert SUnit class ' , className , ' to examples class ' , targetClassName
]

{ #category : #initialization }
GtSUnitToExamplesRefactoring >> initializeModel: aModel from: aClassName to: anExamplesClassName [
	self model: aModel.
	self className: aClassName asSymbol.
	targetClassName := anExamplesClassName asSymbol.
	^ self
]

{ #category : #private }
GtSUnitToExamplesRefactoring >> initializersFor: source slots: slots [
	| initializers setup configurations |
	initializers := Dictionary new.
	configurations := Dictionary new.
	(source directlyDefinesMethod: #setUp) ifFalse: [ ^ initializers ].
	setup := self
			expandedSetupTreeFor: (self setupWorkingCopyOf: source)
			slots: slots.
	setup body statements
		do: [ :statement | 
			self
				collectSetupStatement: statement
				slots: slots
				initializers: initializers
				configurations: configurations ].
	configurations
		keysAndValuesDo: [ :slot :statements | 
			| code |
			code := String
					streamContents: [ :stream | 
						stream
							nextPutAll: '[ ';
							nextPutAll: slot;
							nextPutAll: ' := (';
							nextPutAll: (initializers at: slot) formattedCode;
							nextPutAll: '). '.
						statements
							do: [ :statement | 
								stream
									nextPutAll: statement formattedCode;
									nextPutAll: '. ' ].
						stream
							nextPutAll: slot;
							nextPutAll: ' ]' ].
			initializers at: slot put: (RBParser parseExpression: code) body ].
	^ initializers
]

{ #category : #private }
GtSUnitToExamplesRefactoring >> isSlotRead: node slots: slots [
	^ node isVariable
		and: [ (slots includes: node name)
				and: [ (node whoDefines: node name) isNil and: [ node isRead ] ] ]
]

{ #category : #private }
GtSUnitToExamplesRefactoring >> methodSourcesFor: source slots: slots initializers: initializers [
	| sources readSlots |
	sources := Dictionary new.
	readSlots := slots
			, (model classNamed: self targetSuperclassName) allInstanceVariableNames.
	slots
		do: [ :slot | 
			| expression tree |
			expression := initializers
					at: slot
					ifAbsent: [ RBParser parseExpression: 'nil' ].
			self rewriteReadsIn: expression slots: readSlots.	"Include the root variable read as well as nested reads."
			(self isSlotRead: expression slots: readSlots)
				ifTrue: [ expression := RBParser
							parseExpression: 'self ' , (self getterSelectorForSlot: expression name) ].
			expression isSequence
				ifFalse: [ expression := RBParser
							parseExpression: slot , ' := (' , expression formattedCode , ')' ].
			tree := RBParser
					parseMethod: (self getterSelectorForSlot: slot) asString , ' ^ ' , slot , ' ifNil: [ '
							, expression formattedCode , ' ]'.
			sources at: (self getterSelectorForSlot: slot) put: tree formattedCode ].
	source localSelectors
		do: [ :selector | 
			selector = #setUp
				ifFalse: [ | tree newSelector |
					tree := selector = #tearDown
							ifTrue: [ self tearDownTreeFor: source ]
							ifFalse: [ RBParser parseMethod: (source sourceCodeFor: selector) ].
					newSelector := self exampleSelectorFor: selector.
					newSelector = #class
						ifTrue: [ self error: 'Cannot generate the class selector' ].
					(sources includesKey: newSelector)
						ifTrue: [ self error: 'Getter or example selector collision: ' , newSelector ].
					self rewriteReadsIn: tree slots: readSlots.
					tree selector: newSelector.
					newSelector ~= selector
						ifTrue: [ tree addPragma: (RBParser parseMethod: 'example <gtExample>') pragmas first.
							tree
								addPragma: (RBParser parseMethod: 'example <after: #tearDown>') pragmas first ].
					sources at: newSelector put: tree formattedCode ] ].
	(self targetSuperclassName = #Object
		and: [ (source directlyDefinesMethod: #tearDown) not ])
		ifTrue: [ sources at: #tearDown put: 'tearDown' ].
	^ sources
]

{ #category : #transforming }
GtSUnitToExamplesRefactoring >> privateTransform [
	| source slots initializers sources target |
	source := model classNamed: className.
	slots := source instanceVariableNames.
	initializers := self initializersFor: source slots: slots.
	sources := self
			methodSourcesFor: source
			slots: slots
			initializers: initializers.
	model
		defineClass: self targetSuperclassName , ' subclass: #' , targetClassName
				, (self targetSuperclassName = #Object
						ifTrue: [ ' uses: TAssertable' ]
						ifFalse: [ '' ]) , ' instanceVariableNames: '
				, (' ' join: slots) printString
				, ' classVariableNames: '''' package: ''SUnit-Converted-Examples'''.
	target := model classNamed: targetClassName.
	sources
		keysAndValuesDo: [ :selector :code | 
			target
				compile: code
				classified: ((slots anySatisfy: [ :slot | (self getterSelectorForSlot: slot) = selector ])
						ifTrue: [ #accessing ]
						ifFalse: [ #examples ]) ].
	(source classSide localSelectors reject: [ :selector | selector = #isAbstract ])
		do: [ :selector | 
			target classSide
				compile: (source classSide sourceCodeFor: selector)
				classified: (source classSide protocolsFor: selector) ].
	^ model
]

{ #category : #private }
GtSUnitToExamplesRefactoring >> rewriteReadsIn: tree slots: slots [
	(tree allChildren select: [ :node | self isSlotRead: node slots: slots ])
		do: [ :node | 
			node
				replaceWith: (RBParser parseExpression: 'self ' , (self getterSelectorForSlot: node name)) ].
	^ tree
]

{ #category : #preconditions }
GtSUnitToExamplesRefactoring >> selectorPreconditionsFor: source [
	| selectors conditions |
	selectors := (source instanceVariableNames
			collect: [ :slot | self getterSelectorForSlot: slot ]) asOrderedCollection.
	(source localSelectors reject: [ :selector | selector = #setUp ])
		do: [ :selector | selectors add: (self exampleSelectorFor: selector) ].
	conditions := OrderedCollection new.
	conditions
		add: ((RBCondition withBlock: [ (selectors includes: #class) not ])
				errorMacro: 'Cannot generate the class selector').
	selectors asSet
		do: [ :selector | 
			conditions
				add: ((RBCondition withBlock: [ (selectors occurrencesOf: selector) = 1 ])
						errorMacro: 'Getter or example selector collision: ' , selector) ].
	^ conditions
]

{ #category : #preconditions }
GtSUnitToExamplesRefactoring >> setupPreconditionFor: source [
	"Reuse setup normalization in its existing private workspace."

	| condition |
	condition := RBCondition
			withBlock: [ [ self initializersFor: source slots: source instanceVariableNames.
				true ]
					on: RBRefactoringError , RBRefactoringWarning
					do: [ :error | 
						condition errorMacro: error messageText.
						false ] ].
	condition errorMacro: 'Unsupported setUp'.
	^ condition
]

{ #category : #private }
GtSUnitToExamplesRefactoring >> setupTreeFor: source slots: slots [
	"Inline in the private namespace owning the working source.
	Reparse after each inline to keep selection intervals current."

	| setup assignment |
	setup := RBParser parseMethod: (source sourceCodeFor: #setUp).
	[ setup body temporaries notEmpty ]
		whileTrue: [ assignment := setup assignmentNodes
					detect: [ :node | 
						(setup body temporaryNames includes: node variable name)
							and: [ (node whoDefines: node variable name) == setup body ] ]
					ifNone: [ self
							refactoringError: 'setUp temporary has no assignment to inline' ].
			(RBInlineTemporaryRefactoring
				model: source model
				inline: assignment sourceInterval
				from: #setUp
				in: source) primitiveExecute.
			setup := RBParser parseMethod: (source sourceCodeFor: #setUp) ].
	^ setup
]

{ #category : #private }
GtSUnitToExamplesRefactoring >> setupWorkingCopyOf: source [
	"Snapshot the source and its pending test ancestors for the existing setup inliner."

	| workingModel hierarchy current |
	workingModel := GtRBNamespace onEnvironment: model environment.
	hierarchy := OrderedCollection new.
	current := source.
	[ current name = #TestCase ]
		whileFalse: [ hierarchy addFirst: current.
			current := current superclass ].
	hierarchy
		do: [ :each | 
			| copy |
			workingModel defineClass: each gtDefinitionString.
			copy := workingModel classNamed: each name.
			each localSelectors
				do: [ :selector | 
					copy
						compile: (each sourceCodeFor: selector)
						classified: (each protocolsFor: selector) ] ].
	^ workingModel classNamed: source name
]

{ #category : #preconditions }
GtSUnitToExamplesRefactoring >> sourcePreconditions [
	"Check source support independently of target names and converted parents."

	| source conditions |
	source := self model classNamed: className.
	conditions := OrderedCollection new.
	conditions
		add: ((RBCondition withBlock: [ source notNil ])
				errorMacro: 'Source class does not exist').
	source
		ifNotNil: [ conditions
				add: ((RBCondition
						withBlock: [ source allSuperclasses anySatisfy: [ :each | each name = #TestCase ] ])
						errorMacro: 'Source must inherit from TestCase').
			conditions
				add: ((RBCondition withBlock: [ source classVariableNames isEmpty ])
						errorMacro: 'Class variables require manual conversion').
			(source allSuperclasses anySatisfy: [ :each | each name = #TestCase ])
				ifTrue: [ conditions add: (self setupPreconditionFor: source).
					conditions addAll: (self selectorPreconditionsFor: source) ] ].
	^ conditions
]

{ #category : #accessing }
GtSUnitToExamplesRefactoring >> targetSuperclassName [
	^ targetSuperclassName ifNil: [ #Object ]
]

{ #category : #accessing }
GtSUnitToExamplesRefactoring >> targetSuperclassName: aName [
	targetSuperclassName := aName asSymbol
]

{ #category : #private }
GtSUnitToExamplesRefactoring >> tearDownTreeFor: source [
	| tree |
	tree := RBParser parseMethod: (source sourceCodeFor: #tearDown).
	self targetSuperclassName = #Object
		ifTrue: [  "TestCase's empty hook has no counterpart above the target root."(tree
				allChildren
				select: [ :node | 
					node isMessage
						and: [ node receiver isVariable
								and: [ node receiver isSuper and: [ node selector = #tearDown ] ] ] ])
				do: [ :node | node replaceWith: (RBParser parseExpression: 'self') ] ].
	^ tree
]
