"
Converts direct TestCase subclasses with assignment-only setUp into Object-based Examples classes. Uses the standard class refactoring lifecycle: primitiveExecute builds a preview in the supplied model, while execute applies the changes through the refactoring framework. Setup normalization occurs in a private namespace, leaving the SUnit source unchanged. Reads become lazy getter sends; writes remain assignments. Unsupported lifecycle behavior is rejected rather than discarded.
"
Class {
	#name : #GtSUnitToExamplesRefactoring,
	#superclass : #RBClassRefactoring,
	#instVars : [
		'targetClassName'
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

{ #category : #preconditions }
GtSUnitToExamplesRefactoring >> applicabilityPreconditions [
	| source conditions |
	source := self model classNamed: className.
	conditions := OrderedCollection new.
	conditions
		add: ((RBCondition withBlock: [ source notNil ])
				errorMacro: 'Source class does not exist').
	conditions add: (RBCondition isValidClassName: targetClassName).
	conditions
		add: ((RBCondition withBlock: [ (self model classNamed: targetClassName) isNil ])
				errorMacro: 'Target class already exists').
	source
		ifNotNil: [ conditions
				add: ((RBCondition
						withBlock: [ source superclass notNil and: [ source superclass name = #TestCase ] ])
						errorMacro: 'Only direct TestCase subclasses are supported').
			conditions
				add: ((RBCondition withBlock: [ (source directlyDefinesMethod: #tearDown) not ])
						errorMacro: 'tearDown requires manual conversion').
			conditions
				add: ((RBCondition withBlock: [ source classVariableNames isEmpty ])
						errorMacro: 'Class variables require manual conversion').
			conditions
				add: ((RBCondition withBlock: [ source classSide localSelectors isEmpty ])
						errorMacro: 'Class-side behavior requires manual conversion') ].
	^ self applicabilityPreconditionsFor: conditions
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
				ifTrue: [ self error: 'Setup helper expansion limit exceeded; check for recursion' ].
			(RBInlineMethodRefactoring
				model: source model
				inline: send sourceInterval
				inMethod: #setUp
				forClass: source) primitiveExecute.
			setup := self setupTreeFor: source slots: slots ].
	^ setup
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
	| initializers setup |
	initializers := Dictionary new.
	(source directlyDefinesMethod: #setUp) ifFalse: [ ^ initializers ].
	setup := self
			expandedSetupTreeFor: (self setupWorkingCopyOf: source)
			slots: slots.
	setup body statements
		do: [ :statement | 
			(statement isMessage
				and: [ statement receiver isSuper and: [ statement selector = #setUp ] ])
				ifFalse: [ (statement isAssignment and: [ slots includes: statement variable name ])
						ifFalse: [ self
								error: 'Expanded setUp must contain only direct slot assignments and super setUp' ].
					(statement value containsReturn
						or: [ statement value assignmentNodes notEmpty ])
						ifTrue: [ self error: 'Setup returns and nested assignments require manual conversion' ].
					initializers
						at: statement variable name
						ifAbsentPut: [ statement value copy ] ] ].
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
	| sources |
	sources := Dictionary new.
	slots
		do: [ :slot | 
			| expression tree |
			expression := initializers
					at: slot
					ifAbsent: [ RBParser parseExpression: 'nil' ].
			self rewriteReadsIn: expression slots: slots.	"Include the root variable read as well as nested reads."
			(self isSlotRead: expression slots: slots)
				ifTrue: [ expression := RBParser parseExpression: 'self ' , expression name ].
			tree := RBParser
					parseMethod: slot , ' ^ ' , slot , ' ifNil: [ ' , slot , ' := (' , expression formattedCode
							, ') ]'.
			sources at: slot asSymbol put: tree formattedCode ].
	source localSelectors
		do: [ :selector | 
			(#(setUp tearDown) includes: selector)
				ifFalse: [ | tree newSelector |
					tree := RBParser parseMethod: (source sourceCodeFor: selector).
					newSelector := self exampleSelectorFor: selector.
					(sources includesKey: newSelector)
						ifTrue: [ self error: 'Getter or example selector collision: ' , newSelector ].
					self rewriteReadsIn: tree slots: slots.
					tree selector: newSelector.
					newSelector ~= selector
						ifTrue: [ tree addPragma: (RBParser parseMethod: 'example <gtExample>') pragmas first ].
					sources at: newSelector put: tree formattedCode ] ].
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
		defineClass: 'Object subclass: #' , targetClassName , ' instanceVariableNames: '
				, (' ' join: slots) printString
				, ' classVariableNames: '''' package: ''SUnit-Converted-Examples'''.
	target := model classNamed: targetClassName.
	sources
		keysAndValuesDo: [ :selector :code | 
			target
				compile: code
				classified: ((slots includes: selector asString)
						ifTrue: [ #accessing ]
						ifFalse: [ #examples ]) ].
	^ model
]

{ #category : #private }
GtSUnitToExamplesRefactoring >> rewriteReadsIn: tree slots: slots [
	(tree allChildren select: [ :node | self isSlotRead: node slots: slots ])
		do: [ :node | node replaceWith: (RBParser parseExpression: 'self ' , node name) ].
	^ tree
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
					ifNone: [ self error: 'setUp temporary has no assignment to inline' ].
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
	"Snapshot pending source edits so setup normalization cannot change the caller's model."

	| workingModel workingSource |
	workingModel := GtRBNamespace onEnvironment: model environment.
	workingModel defineClass: source gtDefinitionString.
	workingSource := workingModel classNamed: source name.
	source localSelectors
		do: [ :selector | 
			workingSource
				compile: (source sourceCodeFor: selector)
				classified: (source protocolsFor: selector) ].
	^ workingSource
]
