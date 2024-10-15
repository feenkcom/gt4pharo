Class {
	#name : #GtStrictSymbolRefactor,
	#superclass : #Object,
	#instVars : [
		'methodAst',
		'changes',
		'method',
		'refactoredAst',
		'changed',
		'originalAst'
	],
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Refactoring'
}

{ #category : #'as yet unclassified' }
GtStrictSymbolRefactor class >> equalityNodeFor: methodAst sourceInterval: anInterval [
	| equalityNodes |

	equalityNodes := self equalityNodesFor: methodAst sourceInterval: anInterval.
	equalityNodes size = 1 ifFalse:
		[ self error: 'Unable to find equality node' ].
	^ equalityNodes anyOne
]

{ #category : #'as yet unclassified' }
GtStrictSymbolRefactor class >> equalityNodesFor: methodAst sourceInterval: anInterval [
	"Answer all nodes that match the supplied source interval"

	^ methodAst allChildren select: [ :node |
		node isMessage and: 
		[ node selector == #= and:
		[ node keywordsIntervals includes: anInterval ] ] ].

]

{ #category : #accessing }
GtStrictSymbolRefactor class >> refactoredExtensionPackageName [

	^ '*', self refactoredPackageName
]

{ #category : #accessing }
GtStrictSymbolRefactor class >> refactoredPackageName [

	^ 'GToolkit-Pharo-StrictSymbolRefactored'
]

{ #category : #refactoring }
GtStrictSymbolRefactor >> addAssertionTo: receiver type: type equalityNode: equalityNode comparisonSelector: comparisonSelector change: change [
	| assertionNode |

	(comparisonSelector ~~ #= or: [ change addAssertion not ]) ifTrue: [ ^ self ].

	assertionNode := self assertionNodeFor: receiver type: type.
	(self sequenceNodeFor: equalityNode)
		addNode: assertionNode
		before: equalityNode statementNode.
]

{ #category : #'as yet unclassified' }
GtStrictSymbolRefactor >> addChange: aGtStrictSymbolSignalSummary [

	changes add: aGtStrictSymbolSignalSummary
]

{ #category : #refactoring }
GtStrictSymbolRefactor >> addPragmaTo: methodAst comparisonSelector: comparisonSelector [
	"Add the flag pragma to the method if #= is still being used"
	| pragmaName |

	pragmaName := GtStrictSymbolEqualityArgumentSignal flagPragmaName.
	(comparisonSelector ~~ GtStrictSymbolEqualityArgumentSignal sameContentSelector
		and: [ (methodAst hasPragmaNamed: pragmaName) not ])
		ifTrue: [ methodAst
				addPragma: (RBPragmaNode selector: pragmaName arguments: #()) ]
]

{ #category : #refactoring }
GtStrictSymbolRefactor >> addStringOrSymbolAssertionTo: receiver equalityNode: equalityNode argument: argument [

	"addAssertion ifFalse: [ ^ self ]."

	(self sequenceNodeFor: equalityNode)
		addNode: (self assertionNodeForStringOrSymbol: receiver argument: argument)
		before: equalityNode statementNode.
]

{ #category : #refactoring }
GtStrictSymbolRefactor >> assertionNodeFor: leftNode type: leftType [ 
	| selector |
	
	selector := leftType = 'String'
		ifTrue: [ #assertIsStringWhenStrict: ]
		ifFalse: [ #assertIsSymbolWhenStrict: ].
	^ RBMessageNode 
		receiver: (RBVariableNode named: 'self')
		selector: selector
		arguments: { leftNode copy }.

]

{ #category : #refactoring }
GtStrictSymbolRefactor >> assertionNodeForSameClassReceiver: receiver argument: argument [

	^ RBMessageNode 
		receiver: (RBVariableNode named: 'self')
		selector: #assertSameTypeWhenStrict:and:
		arguments: { receiver copy. argument copy }.

]

{ #category : #refactoring }
GtStrictSymbolRefactor >> assertionNodeForStringOrSymbol: receiver argument: argument [

	^ RBMessageNode 
		receiver: (RBVariableNode named: 'self')
		selector: #assertStringOrSymbolWhenStrict:and:
		arguments: { receiver copy. argument copy }.

]

{ #category : #private }
GtStrictSymbolRefactor >> comparisonSelectorFor: aString [

	^ (#('String' 'Symbol') includes: aString) 
		ifTrue: [ #= ] 
		ifFalse: [ #sameContentAs: ]
]

{ #category : #'as yet unclassified' }
GtStrictSymbolRefactor >> equalityNodeFor: change [ 

	^ self class
			equalityNodeFor: methodAst
			sourceInterval: change sourceIntervals first
]

{ #category : #'as yet unclassified' }
GtStrictSymbolRefactor >> gtDiffFor: aView [
	<gtView>

	method ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Diff';
		priority: 10;
		stencil: [ | previousContent newContent change |
			previousContent := self originalAst sourceCode.
			newContent := self refactoredAst sourceCode.

			change := GtDiffBuilder
					computeDifferencesFrom: previousContent
					to: newContent
					using: GtSmaCCDiffSplitter forPharo.
			GtEpiceaDiffElementWithLabelStencil new
				fromLabelText: 'Current:';
				toLabelText: 'Change:';
				ombuEntry: self;
				change: change;
				styler: (GtCodeDiffRBTextStyler new isForWorkspace: false) ]
]

{ #category : #'as yet unclassified' }
GtStrictSymbolRefactor >> gtNewSourceCodeFor: aView [
	<gtView>

	method ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'New Source Code';
		priority: 30;
		object: [ self refactoredAst ];
		view: #gtSourceCodeFor:
]

{ #category : #'as yet unclassified' }
GtStrictSymbolRefactor >> gtSourceCodeFor: aView [
	<gtView>

	method ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Source Code';
		priority: 20;
		object: [ self method ];
		view: #gtSourceCodeFor:
]

{ #category : #'as yet unclassified' }
GtStrictSymbolRefactor >> initialize [

	super initialize.
	changes := OrderedCollection new.
]

{ #category : #testing }
GtStrictSymbolRefactor >> isChanged [

	^ changed ifNil: [ self refactoredAst. changed ]
]

{ #category : #refactoring }
GtStrictSymbolRefactor >> literalConverterFor: aString [

	^ aString = 'Symbol'
		ifTrue: [ #asSymbol ]
		ifFalse: [ #asString ]
]

{ #category : #accessing }
GtStrictSymbolRefactor >> method [

	^ method
]

{ #category : #'as yet unclassified' }
GtStrictSymbolRefactor >> method: aCompiledMethod [

	method := aCompiledMethod.
	originalAst := aCompiledMethod parseTree.
	methodAst := originalAst copy.
	refactoredAst := nil.
]

{ #category : #accessing }
GtStrictSymbolRefactor >> methodAst [
	^ methodAst
]

{ #category : #accessing }
GtStrictSymbolRefactor >> originalAst [
	^ originalAst
]

{ #category : #'as yet unclassified' }
GtStrictSymbolRefactor >> refactor [

	(self shouldRefactor and: [ self isChanged ]) ifFalse: [ ^ self ].
	self method methodClass
		compile: self refactoredAst sourceCode
		classified: self class refactoredExtensionPackageName.
]

{ #category : #refactoring }
GtStrictSymbolRefactor >> refactorExpressionEqualsLiteralFor: equalityNode change: change [
	| comparisonSelector literalConverter literal argument receiver |

	comparisonSelector := self comparisonSelectorFor: change leftType.
	literalConverter := self literalConverterFor: change leftType.
	argument := equalityNode arguments first value.
	receiver := equalityNode receiver.

	literal := argument perform: literalConverter.
	equalityNode
		selector: comparisonSelector;
		arguments: {RBLiteralValueNode value: literal}.
	self
		addAssertionTo: receiver
		type: change leftType
		equalityNode: equalityNode
		comparisonSelector: comparisonSelector
		change: change.
	self addPragmaTo: methodAst comparisonSelector: comparisonSelector.
	^ methodAst
]

{ #category : #refactoring }
GtStrictSymbolRefactor >> refactorLiteralEqualsExpressionFor: equalityNode change: change [
	| comparisonSelector literalConverter literal receiver argument |

	comparisonSelector := self comparisonSelectorFor: change rightType.
	literalConverter := self literalConverterFor: change rightType.
	receiver := equalityNode receiver.
	argument := equalityNode arguments first.
	self assert: receiver class == RBLiteralValueNode.
	self assert: argument class == RBVariableNode.

	literal := receiver value perform: literalConverter.
	equalityNode
		receiver: (RBLiteralValueNode value: literal);
		selector: comparisonSelector.
	self
		addAssertionTo: argument 
		type: change rightType 
		equalityNode: equalityNode 
		comparisonSelector: comparisonSelector
		change: change.
	self addPragmaTo: methodAst comparisonSelector: comparisonSelector.
	^ methodAst
]

{ #category : #refactoring }
GtStrictSymbolRefactor >> refactorSameClassEqualsExpressionFor: equalityNode change: change [
	| argument receiver |

	argument := equalityNode arguments first value.
	receiver := equalityNode receiver.

	self addStringOrSymbolAssertionTo: receiver
		equalityNode: equalityNode
		argument: argument.
	self addPragmaTo: methodAst comparisonSelector: #=.
	^ methodAst
]

{ #category : #refactoring }
GtStrictSymbolRefactor >> refactorToSameContentAs [
	"Convert all #= sends to the sameContentSelector"
	| equalityNodes sameContentSelector |

	equalityNodes := methodAst allChildren select: [ :node |
		node isMessage and: [ node selector == #= ] ].
	sameContentSelector := GtStrictSymbolEqualityArgumentSignal sameContentSelector.
	equalityNodes do: [ :equalityNode |
		self assert: equalityNode selector = #=.
		equalityNode selector: sameContentSelector ].

	self addPragmaTo: methodAst comparisonSelector: sameContentSelector.
	^ methodAst
]

{ #category : #refactoring }
GtStrictSymbolRefactor >> refactorToSameContentAsFor: equalityNode change: change [
	| sameContentSelector |

	sameContentSelector := GtStrictSymbolEqualityArgumentSignal sameContentSelector.
	equalityNode selector: sameContentSelector.

	self addPragmaTo: methodAst comparisonSelector: sameContentSelector.
	^ methodAst
]

{ #category : #'as yet unclassified' }
GtStrictSymbolRefactor >> refactoredAst [
	| equalityNodes |

	refactoredAst ifNotNil: [ ^ refactoredAst ].

	(changes allSatisfy: #isValid) ifFalse:
		[ self refactorToSameContentAs.
		changed := methodAst = originalAst.
		^ refactoredAst := RBParser parseMethod: methodAst newSource ].

	equalityNodes := changes collect: [ :change |
		self equalityNodeFor: change ].

	changes with: equalityNodes do: [ :change :equalityNode |
		self refactoredAstFor: equalityNode change: change ].

	refactoredAst := RBParser parseMethod: methodAst newSource.
	changed := refactoredAst ~= originalAst.
	^ refactoredAst
]

{ #category : #'as yet unclassified' }
GtStrictSymbolRefactor >> refactoredAstFor: equalityNode change: change [ 

	change shouldRefactor ifFalse: [ ^ methodAst ].

	change rightIsLiteral ifTrue:
		[ ^ self refactorExpressionEqualsLiteralFor: equalityNode 
			change: change ].
	change leftIsLiteral ifTrue:
		[ ^ self refactorLiteralEqualsExpressionFor: equalityNode 
			change: change ].
	(change canBeStrict and:
		[ #('String' 'Symbol') includes: change leftType ]) ifTrue:
			[ ^ self refactorSameClassEqualsExpressionFor: equalityNode 
				change: change ].
	^ self refactorToSameContentAsFor: equalityNode change: change
]

{ #category : #private }
GtStrictSymbolRefactor >> sequenceNodeFor: equalityNode [ 
	| sequenceNode |

	sequenceNode := equalityNode.
	[ sequenceNode isSequence ] whileFalse:
		[ sequenceNode := sequenceNode parent ].
	^ sequenceNode
]

{ #category : #testing }
GtStrictSymbolRefactor >> shouldRefactor [

	^ changes anySatisfy: #shouldRefactor
]
