"
I exemplify {{gtClass:GtCoderExampleTimeLimitStyler}}, which decorates `<timeLimit:>` example pragmas with a human readable duration.
"
Class {
	#name : #GtCoderExampleTimeLimitStylerExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #'examples - styling' }
GtCoderExampleTimeLimitStylerExamples >> assertSourceCode: aSourceString decoratedWith: aCollectionOfDecorations [
	"Style the source code and assert the time limit decorations.
	The decorations are given as literal -> decoration string associations."

	| aText theExpectedDecorations |
	aText := self styleSourceCode: aSourceString.

	theExpectedDecorations := aCollectionOfDecorations asArray
			collect: [ :each | (aSourceString indexOfSubCollection: each key) + each key size - 1 -> each value ].

	self
		assert: (self timeLimitDecorationsIn: aText)
		equals: theExpectedDecorations.
	self assert: aText asString equals: aSourceString.

	^ aText
]

{ #category : #'examples - add-ons' }
GtCoderExampleTimeLimitStylerExamples >> exampleAddOnsFor: aCompiledMethod [
	| aCoder someAddOns |
	aCoder := GtPharoMethodCoder forMethod: aCompiledMethod.
	someAddOns := aCoder addOns class new.
	aCoder
		timeLimitPragmaAst: aCoder astSync
		into: someAddOns
		viewModel: aCoder asCoderViewModel.
	^ someAddOns
]

{ #category : #'examples - add-ons' }
GtCoderExampleTimeLimitStylerExamples >> exampleMethodCoderHasTimeLimitStyler [
	<gtExample>
	<return: #GtTextualCoderAddOns>
	| someAddOns |
	someAddOns := self exampleAddOnsFor: self class >> #methodWithTimeLimit.

	self
		assert: (someAddOns stylers
				count: [ :each | each class = GtCoderExampleTimeLimitStyler ])
		equals: 1.

	^ someAddOns
]

{ #category : #'examples - scripter' }
GtCoderExampleTimeLimitStylerExamples >> methodCoderEditorShowsTimeLimitDecoration [
	<gtExample>
	<return: #BlScripter>
	| aScripter aSourceString aPosition |
	aSourceString := (self class >> #methodWithTimeLimit) sourceCode.
	aPosition := (aSourceString indexOfSubCollection: '120000') + 5.

	aScripter := self
			scripterForBlock: [ (GtPharoMethodCoder forMethod: self class >> #methodWithTimeLimit)
					asCoderViewModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert time limit decoration';
				satisfies: [ :aCoderEditor | 
					(self timeLimitDecorationsIn: aCoderEditor text)
						= {aPosition -> ' ms (2 minutes)'} ];
				id: GtSourceCoderEditorId ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert source code is not changed';
				satisfies: [ :aCoderEditor | aCoderEditor text asString = aSourceString ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #'sample methods' }
GtCoderExampleTimeLimitStylerExamples >> methodWithManyTimeLimits [
	"Several time limits to show their decorations at once, see #timeLimitsOverview"

	<timeLimit: 500>
	<timeLimit: 1000>
	<timeLimit: 1500.5>
	<timeLimit: 30000>
	<timeLimit: 61500>
	<timeLimit: 90000>
	<timeLimit: 120000>
	<timeLimit: 150000>
	<timeLimit: 180000>
	<timeLimit: 3600000>
	<timeLimit: 5400000>
	<timeLimit: 7200000>
	<timeLimit: 10000000>
	^ 42
]

{ #category : #'sample methods' }
GtCoderExampleTimeLimitStylerExamples >> methodWithTimeLimit [
	<gtExample>
	<timeLimit: 120000>
	<return: #SmallInteger>
	^ 42
]

{ #category : #'sample methods' }
GtCoderExampleTimeLimitStylerExamples >> methodWithTimeLimitButNotExample [
	<timeLimit: 120000>
	^ 42
]

{ #category : #'sample methods' }
GtCoderExampleTimeLimitStylerExamples >> methodWithoutTimeLimit [
	<gtExample>
	<return: #SmallInteger>
	^ 42
]

{ #category : #'examples - add-ons' }
GtCoderExampleTimeLimitStylerExamples >> methodWithoutTimeLimitHasNoTimeLimitStyler [
	<gtExample>
	<return: #GtTextualCoderAddOns>
	| someAddOns |
	someAddOns := self exampleAddOnsFor: self class >> #methodWithoutTimeLimit.

	self
		assert: (someAddOns stylers
				noneSatisfy: [ :each | each class = GtCoderExampleTimeLimitStyler ]).

	^ someAddOns
]

{ #category : #'examples - styling' }
GtCoderExampleTimeLimitStylerExamples >> negativeTimeLimitIsNotDecorated [
	<gtExample>
	<return: #BlRunRopedText>
	^ self
		assertSourceCode: 'foo <gtExample> <timeLimit: -1000> ^ 42'
		decoratedWith: #()
]

{ #category : #'examples - add-ons' }
GtCoderExampleTimeLimitStylerExamples >> newMethodCoderHasTimeLimitStyler [
	<gtExample>
	<return: #GtTextualCoderAddOns>
	| aCoder someAddOns |
	aCoder := GtPharoMethodCoder
			forClass: self class
			source: ('newMethodWithTimeLimit {1}<timeLimit: 120000>{1}^ 42' format: { String cr, String tab}).
	self assert: aCoder compiledMethod isNil.

	someAddOns := aCoder addOns class new.
	aCoder
		timeLimitPragmaAst: aCoder astSync
		into: someAddOns
		viewModel: aCoder asCoderViewModel.

	self
		assert: (someAddOns stylers
				count: [ :each | each class = GtCoderExampleTimeLimitStyler ])
		equals: 1.

	^ aCoder
]

{ #category : #'examples - add-ons' }
GtCoderExampleTimeLimitStylerExamples >> nonExampleMethodCoderHasTimeLimitStyler [
	<gtExample>
	<return: #GtTextualCoderAddOns>
	| someAddOns |
	someAddOns := self
			exampleAddOnsFor: self class >> #methodWithTimeLimitButNotExample.

	self
		assert: (someAddOns stylers
				count: [ :each | each class = GtCoderExampleTimeLimitStyler ])
		equals: 1.

	^ someAddOns
]

{ #category : #'examples - styling' }
GtCoderExampleTimeLimitStylerExamples >> otherPragmasAreNotDecorated [
	<gtExample>
	<return: #BlRunRopedText>
	^ self
		assertSourceCode: 'foo <gtExample> <priority: 120000> <timeLimit: 3000> ^ 120000'
		decoratedWith: {'3000' -> ' ms (3 seconds)'}
]

{ #category : #'examples - styling' }
GtCoderExampleTimeLimitStylerExamples >> sourceCodeIsNotChanged [
	<gtExample>
	<return: #GtPharoMethodCoder>
	| aCoder aSourceString |
	aCoder := GtPharoMethodCoder forMethod: self class >> #methodWithTimeLimit.
	aSourceString := aCoder currentSourceString.

	GtCoderExampleTimeLimitStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aCoder currentSourceText ast: aCoder astSync.

	self assert: aCoder currentSourceString equals: aSourceString.
	self
		assert: aCoder currentSourceString
		equals: (self class >> #methodWithTimeLimit) sourceCode.

	^ aCoder
]

{ #category : #'examples - styling' }
GtCoderExampleTimeLimitStylerExamples >> styleSourceCode: aSourceString [
	| aCoder aText |
	aCoder := GtPharoMethodCoder forClass: self class source: aSourceString.
	aText := aCoder currentSourceText copy.

	GtCoderExampleTimeLimitStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aText ast: aCoder astSync.

	^ aText
]

{ #category : #'examples - styling' }
GtCoderExampleTimeLimitStylerExamples >> timeLimitApproximatedInMinutes [
	<gtExample>
	<return: #BlRunRopedText>
	^ self
		assertSourceCode: 'foo <gtExample> <timeLimit: 150000> ^ 42'
		decoratedWith: {'150000' -> ' ms (~3 minutes)'}
]

{ #category : #'examples - styling' }
GtCoderExampleTimeLimitStylerExamples >> timeLimitApproximatedInSeconds [
	<gtExample>
	<return: #BlRunRopedText>
	^ self
		assertSourceCode: 'foo <gtExample> <timeLimit: 61500> ^ 42'
		decoratedWith: {'61500' -> ' ms (~62 seconds)'}
]

{ #category : #'examples - styling' }
GtCoderExampleTimeLimitStylerExamples >> timeLimitBelowOneSecond [
	<gtExample>
	<return: #BlRunRopedText>
	^ self
		assertSourceCode: 'foo <gtExample> <timeLimit: 500> ^ 42'
		decoratedWith: {'500' -> ' ms'}
]

{ #category : #'examples - styling' }
GtCoderExampleTimeLimitStylerExamples >> timeLimitDecorationsIn: aText [
	"Return position -> decoration string associations of all appended text adornments"

	| allDecorations |
	allDecorations := OrderedCollection new.
	aText
		findAttributesSuchThat: [ :eachAttribute | 
			(eachAttribute isKindOf: BrTextAdornmentTextAttribute)
				and: [ eachAttribute shouldAppend ] ]
		indicesDo: [ :aStartPosition :anEndPosition | 
			(aText attributesAt: anEndPosition)
				do: [ :eachAttribute | 
					((eachAttribute isKindOf: BrTextAdornmentTextAttribute)
						and: [ eachAttribute shouldAppend ])
						ifTrue: [ allDecorations add: anEndPosition -> eachAttribute text asString ] ] ].
	^ allDecorations asArray
]

{ #category : #'examples - styling' }
GtCoderExampleTimeLimitStylerExamples >> timeLimitOfNinetyMinutes [
	<gtExample>
	<return: #BlRunRopedText>
	^ self
		assertSourceCode: 'foo <gtExample> <timeLimit: 5400000> ^ 42'
		decoratedWith: {'5400000' -> ' ms (90 minutes)'}
]

{ #category : #'examples - styling' }
GtCoderExampleTimeLimitStylerExamples >> timeLimitOfNinetySeconds [
	<gtExample>
	<return: #BlRunRopedText>
	^ self
		assertSourceCode: 'foo <gtExample> <timeLimit: 90000> ^ 42'
		decoratedWith: {'90000' -> ' ms (90 seconds)'}
]

{ #category : #'examples - styling' }
GtCoderExampleTimeLimitStylerExamples >> timeLimitOfOneSecond [
	<gtExample>
	<return: #BlRunRopedText>
	^ self
		assertSourceCode: 'foo <gtExample> <timeLimit: 1000> ^ 42'
		decoratedWith: {'1000' -> ' ms (1 second)'}
]

{ #category : #'examples - styling' }
GtCoderExampleTimeLimitStylerExamples >> timeLimitOfTwoMinutes [
	<gtExample>
	<return: #BlRunRopedText>
	^ self
		assertSourceCode: 'foo <gtExample> <timeLimit: 120000> ^ 42'
		decoratedWith: {'120000' -> ' ms (2 minutes)'}
]

{ #category : #'examples - styling' }
GtCoderExampleTimeLimitStylerExamples >> timeLimitWithFraction [
	<gtExample>
	<return: #BlRunRopedText>
	^ self
		assertSourceCode: 'foo <gtExample> <timeLimit: 1500.5> ^ 42'
		decoratedWith: {'1500.5' -> ' ms (~2 seconds)'}
]

{ #category : #'examples - styling' }
GtCoderExampleTimeLimitStylerExamples >> timeLimitWithSymbolIsNotDecorated [
	<gtExample>
	<return: #BlRunRopedText>
	^ self
		assertSourceCode: 'foo <gtExample> <timeLimit: #oneMinute> ^ 42'
		decoratedWith: #()
]

{ #category : #'examples - scripter' }
GtCoderExampleTimeLimitStylerExamples >> timeLimitsOverview [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterForBlock: [ (GtPharoMethodCoder forMethod: self class >> #methodWithManyTimeLimits)
					asCoderViewModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert time limit decorations';
				satisfies: [ :aCoderEditor | 
					((self timeLimitDecorationsIn: aCoderEditor text) collect: #value)
						= #(' ms' ' ms (1 second)' ' ms (~2 seconds)' ' ms (30 seconds)' ' ms (~62 seconds)' ' ms (90 seconds)' ' ms (2 minutes)' ' ms (~3 minutes)' ' ms (3 minutes)' ' ms (1 hour)' ' ms (90 minutes)' ' ms (2 hours)' ' ms (~3 hours)') ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]
