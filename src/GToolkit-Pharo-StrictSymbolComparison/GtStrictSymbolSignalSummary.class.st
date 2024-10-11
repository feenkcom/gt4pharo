Class {
	#name : #GtStrictSymbolSignalSummary,
	#superclass : #Object,
	#instVars : [
		'leftType',
		'rightType',
		'methodName',
		'pc',
		'sampleCount',
		'sourceIntervals',
		'addAssertion'
	],
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Analysis'
}

{ #category : #accessing }
GtStrictSymbolSignalSummary >> addAssertion [
	^ addAssertion
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> addAssertion: anObject [
	addAssertion := anObject
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> canBeStrict [
	^ leftType = rightType
]

{ #category : #printing }
GtStrictSymbolSignalSummary >> comparisonSelector [
	| comparisonSelector |

	comparisonSelector := self canBeStrict
		ifTrue: [ #= ]
		ifFalse: [ #sameContentAs: ].
	self leftIsLiteral ifTrue: 
		[ comparisonSelector := GtStrictSymbolRefactor new 
			comparisonSelectorFor: rightType ].
	self rightIsLiteral ifTrue: 
		[ comparisonSelector := GtStrictSymbolRefactor new 
			comparisonSelectorFor: leftType ].
	^ comparisonSelector
]

{ #category : #testing }
GtStrictSymbolSignalSummary >> equalityNodeFor: methodAst sourceInterval: sourceInterval [

	^ GtStrictSymbolRefactor equalityNodeFor: methodAst sourceInterval: sourceInterval
]

{ #category : #initialization }
GtStrictSymbolSignalSummary >> from: aGtStrictSymbolItem [

	self assert: methodName isNil.
	methodName := aGtStrictSymbolItem methodName.
	pc := aGtStrictSymbolItem pc.
	sourceIntervals := aGtStrictSymbolItem sourceIntervals.
	leftType := aGtStrictSymbolItem leftType.
	rightType := aGtStrictSymbolItem rightType.
	sampleCount := 1.
]

{ #category : #ui }
GtStrictSymbolSignalSummary >> gtApplyActionFor: anAction [
	<gtAction>

	methodName ifNil: [ ^ anAction noAction ].
	^ anAction button
		label: 'Apply';
		icon: BrGlamorousVectorIcons accept;
		action: [ :aButton |
			aButton phlow spawnObject: self refactor ].
]

{ #category : #ui }
GtStrictSymbolSignalSummary >> gtDiffFor: aView [
	<gtView>

	methodName ifNil: [ ^ aView empty ].
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

{ #category : #ui }
GtStrictSymbolSignalSummary >> gtNewSourceCodeFor: aView [
	<gtView>

	methodName ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'New Source Code';
		priority: 30;
		object: [ self refactoredAst ];
		view: #gtSourceCodeFor:
]

{ #category : #ui }
GtStrictSymbolSignalSummary >> gtSourceCodeFor: aView [
	<gtView>

	methodName ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Source Code';
		priority: 20;
		object: [ self method ];
		view: #gtSourceCodeFor:
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> hasMultipleIntervals [

	^ sourceIntervals isNotNil and:
		[ sourceIntervals size > 1 ]
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> id [

	^ sourceIntervals
		ifNil: [ methodName, '@', pc asString ]
		ifNotNil: 
			[ String streamContents: [ :stream |
				stream
					<< methodName;
					<< '@'.
				sourceIntervals do: [ :aSourceInterval |
					stream
						<< aSourceInterval first asString;
						<< '-';
						<< aSourceInterval stop asString ]
					separatedBy: [ stream nextPut: $, ] ] ].
]

{ #category : #initialization }
GtStrictSymbolSignalSummary >> initialize [

	super initialize.
	addAssertion := false.
]

{ #category : #testing }
GtStrictSymbolSignalSummary >> isAssertionOnly [
	"Answer a boolean indicating whether the refactoring would only add an (optional) assertion."

	^ (self leftIsLiteral or: [ self rightIsLiteral ]) and:
		[ leftType = rightType ]
]

{ #category : #testing }
GtStrictSymbolSignalSummary >> isLiteralTypeCorrection [
	"Answer a boolean indicating whether the refactoring would changes the type of the literal."

	^ (self leftIsLiteral or: [ self rightIsLiteral ]) and:
		[ leftType ~= rightType ]
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> isValid [

	^ methodName isNotNil and:
		[ sourceIntervals isNotNil and:
		[ sourceIntervals size = 1 and:
		[ (GtStrictSymbolRefactor
			equalityNodesFor: self method parseTree
			sourceInterval: sourceIntervals anyOne) size = 1 ] ] ]
]

{ #category : #testing }
GtStrictSymbolSignalSummary >> leftIsLiteral [
	| methodAst equalityNode receiver |

	self assert: sourceIntervals size = 1.
	methodAst := self method parseTree.
	equalityNode := self equalityNodeFor: methodAst sourceInterval: sourceIntervals first.
	self assert: equalityNode selector = #=.
	receiver := equalityNode receiver.
	^ receiver class = RBLiteralValueNode and:
		[ receiver value isKindOf: String ]
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> leftType [
	^ leftType
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> leftType: anObject [
	leftType := anObject
]

{ #category : #initialization }
GtStrictSymbolSignalSummary >> merge: aGtStrictSymbolItem [

	self assert: (self id sameContentAs: aGtStrictSymbolItem id).
	(leftType sameContentAs: aGtStrictSymbolItem leftType)
		ifFalse: [ leftType := #mixed ].
	(rightType sameContentAs: aGtStrictSymbolItem rightType)
		ifFalse: [ rightType := #mixed ].
	sampleCount := sampleCount + 1.
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> method [

	^ self class compiler evaluate: methodName.
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> methodName [
	^ methodName
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> methodName: anObject [
	methodName := anObject
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> originalAst [

	^ self method parseTree
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> parsedAst [

	^ RBParser parseMethod: self refactoredAst newSource
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> pc [
	^ pc
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> pc: anObject [
	pc := anObject
]

{ #category : #printing }
GtStrictSymbolSignalSummary >> printOn: aStream [

	methodName ifNil: [ ^ super printOn: aStream ].
	aStream 
		print: self canBeStrict;
		<< ' (';
		print: sampleCount;
		<< ')'
]

{ #category : #actions }
GtStrictSymbolSignalSummary >> refactor [

	self shouldRefactor ifFalse: [ ^ self ].
	GtStrictSymbolRefactor new
		method: self method;
		addChange: self;
		refactor.
	^ self class new
		methodName: methodName;
		leftType: leftType;
		rightType: rightType;
		sampleCount: sampleCount;
		addAssertion: addAssertion
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> refactoredAst [

	^ self strictSymbolRefactor refactoredAst
]

{ #category : #testing }
GtStrictSymbolSignalSummary >> rightIsLiteral [
	| methodAst equalityNode argument |

	self assert: sourceIntervals size = 1.
	methodAst := self method parseTree.
	equalityNode := self equalityNodeFor: methodAst sourceInterval: sourceIntervals first.
	self assert: equalityNode selector = #=.
	argument := equalityNode arguments first.
	^ argument class = RBLiteralValueNode and:
		[ argument value isKindOf: String ]
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> rightType [
	^ rightType
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> rightType: anObject [
	rightType := anObject
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> sampleCount [

	^ sampleCount
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> sampleCount: anObject [
	sampleCount := anObject
]

{ #category : #testing }
GtStrictSymbolSignalSummary >> shouldRefactor [

	^ addAssertion or: [ self canBeStrict not ]
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> sourceIntervals [

	^ sourceIntervals
]

{ #category : #accessing }
GtStrictSymbolSignalSummary >> strictSymbolRefactor [

	^ GtStrictSymbolRefactor new
		method: self method;
		addChange: self
]

{ #category : #printing }
GtStrictSymbolSignalSummary >> summaryString [
	| comparisonSelector leftLabel rightLabel |

	leftLabel := leftType.
	rightLabel := rightType.
	comparisonSelector := self canBeStrict
		ifTrue: [ #= ]
		ifFalse: [ GtStrictSymbolEqualityArgumentSignal sameContentSelector ].
	self leftIsLiteral ifTrue: 
		[ comparisonSelector := GtStrictSymbolRefactor new 
			comparisonSelectorFor: rightType.
		leftLabel := 'Literal ', leftType asString. ].
	self rightIsLiteral ifTrue: 
		[ comparisonSelector := GtStrictSymbolRefactor new 
			comparisonSelectorFor: leftType.
		rightLabel := 'Literal ', rightType asString ].
	^ leftLabel, ' ', comparisonSelector, ' ', rightLabel
]

{ #category : #testing }
GtStrictSymbolSignalSummary >> usesSameContentAs [

	^ self comparisonSelector == GtStrictSymbolEqualityArgumentSignal sameContentSelector
]
