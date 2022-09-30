Class {
	#name : #GtPharoExampleSuiteExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : #'GToolkit-Pharo-TestSuite-Examples'
}

{ #category : #'examples - example suite' }
GtPharoExampleSuiteExamples >> assertIn: aStep allExamplesWithSomeExamples: aBoolean [
	<gtExample>
	aStep assert
		label: ('All examples label is visible {1}'
				format: {aBoolean ifTrue: [ 'with a non-zero amount' ] ifFalse: [ 'with zero amount' ]});
		satisfies: [ :aStateAmountLabel | aStateAmountLabel text asString ~= '0' = aBoolean ];
		onSpaceRoot;
		id: (GtPharoSuiteStateId new state: GtFilterExampleAllState uniqueInstance);
		id: GtPharoSuiteStateAmountLabelId;
		play
]

{ #category : #'examples - example suite' }
GtPharoExampleSuiteExamples >> assertIn: aParentStep exampleCountsOfAll: allCount success: successCount failure: failureCount error: errorCount notExecuted: notExecutedCount [
	<gtExample>
	aParentStep
		checks: 'Assert displayed example results'
		do: [ :aStep | 
			aStep assert
				label: 'All examples label';
				satisfies: [ :aStateAmountLabel | aStateAmountLabel text asString = allCount asString ];
				onSpaceRoot;
				id: (GtPharoSuiteStateId new state: GtFilterExampleAllState uniqueInstance);
				id: GtPharoSuiteStateAmountLabelId;
				play ]
]

{ #category : #'examples - example suite' }
GtPharoExampleSuiteExamples >> assertIn: aStep localToggleActive: localActivated playEnabled: playIsEnabled withLabel: playLabel [
	<gtExample>
	aStep assert
		label: ('Play button is {1} with label "{2}"'
				format: {playIsEnabled ifTrue: [ 'enabled' ] ifFalse: [ 'disabled' ].
						playLabel});
		satisfies: [ :aPlayButton | 
			aPlayButton isEnabled = playIsEnabled
				and: [ aPlayButton label asString = playLabel ] ];
		onSpaceRoot;
		id: GtPharoSuitePlayButtonId;
		play.

	aStep assert
		label: ('Local toggle is enabled and {1}'
				format: {localActivated ifTrue: [ 'actived' ] ifFalse: [ 'inactivated' ]});
		satisfies: [ :aToggle | aToggle isEnabled and: [ aToggle isActivated = localActivated ] ];
		onSpaceRoot;
		id: GtPharoSuiteLocalToggleId;
		play.

	aStep assert
		label: ('Remote toggle is enabled and {1}'
				format: {localActivated ifFalse: [ 'actived' ] ifTrue: [ 'inactivated' ]});
		satisfies: [ :aToggle | aToggle isEnabled and: [ aToggle isActivated = localActivated not ] ];
		onSpaceRoot;
		id: GtPharoSuiteRemoteToggleId;
		play.

	aStep assert
		label: ('Suite view model with {1} executor'
				format: {localActivated ifTrue: [ 'local' ] ifFalse: [ 'remote' ]});
		satisfies: [ :aScripter | (aScripter userData at: #suiteViewModel) isLocal = localActivated ];
		onScripter;
		play
]

{ #category : #'examples - example suite' }
GtPharoExampleSuiteExamples >> classCoderWithExampleMethods [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aClass |
				aClass := self classWithExamples.
				aClass gtExamples
					do: [ :eachExample | eachExample method clearExampleAndTestCaches ].
				GtCoder forClass: aClass ].

	aScripter set
		label: 'Store suite view model';
		key: #suiteViewModel value: [ :aButton | aButton suiteViewModel ];
		id: GtPharoExampleSuiteShowButtonId;
		play.

	aScripter
		checks: 'Initial state assertions'
		do: [ :aStep | 
			aStep assert
				label: 'Assert example button exists';
				exists;
				id: GtPharoExampleSuiteShowButtonId;
				play.

			aStep assert
				label: 'Example button is enabled and visible';
				satisfies: [ :aButton | aButton isEnabled and: [ aButton visibility = BlVisibility visible ] ];
				id: GtPharoExampleSuiteShowButtonId;
				play.

			aStep assert
				label: 'Test button is gone';
				satisfies: [ :aButton | aButton visibility = BlVisibility gone ];
				id: GtPharoTestSuiteShowButtonId;
				play ].

	^ aScripter
]

{ #category : #'examples - dummy examples' }
GtPharoExampleSuiteExamples >> classWithExamples [
	<gtExample>
	^ GtPharoExampleSuiteDummyExamples
]

{ #category : #'examples - example suite' }
GtPharoExampleSuiteExamples >> clickOnRemoteToggle [
	<gtExample>
	| aScripter |
	aScripter := self openExampleDropdown.

	aScripter
		substep: 'Choose remote execution'
		do: [ :aStep | 
			aStep click
				label: 'Click on remote toggle';
				onSpaceRoot;
				id: GtPharoSuiteRemoteToggleId;
				play.

			self
				assertIn: aStep
				localToggleActive: false
				playEnabled: true
				withLabel: 'Run'.

			self
				assertIn: aStep
				exampleCountsOfAll: self numberOfExamples
				success: 0
				failure: 0
				error: 0
				notExecuted: self numberOfExamples ].

	^ aScripter
]

{ #category : #'examples - dummy examples' }
GtPharoExampleSuiteExamples >> numberOfExamples [
	<gtExample>
	| aCount |
	aCount := self classWithExamples gtExamples size.
	self
		assert: aCount isZero not
		description: [ '{1} must have examples' format: {self classWithExamples} ].

	^ aCount
]

{ #category : #'examples - example suite' }
GtPharoExampleSuiteExamples >> openExampleDropdown [
	<gtExample>
	| aScripter |
	aScripter := self classCoderWithExampleMethods.

	aScripter
		substep: 'Display example Dropdown'
		do: [ :aStep | 
			aStep click
				label: 'Click on example button';
				id: GtPharoExampleSuiteShowButtonId;
				play.

			self
				assertIn: aStep
				localToggleActive: true
				playEnabled: true
				withLabel: 'Run'.

			self
				assertIn: aStep
				exampleCountsOfAll: self numberOfExamples
				success: 0
				failure: 0
				error: 0
				notExecuted: self numberOfExamples ].

	^ aScripter
]

{ #category : #'examples - example suite' }
GtPharoExampleSuiteExamples >> runExamplesLocally [
	<gtExample>
	| aScripter |
	aScripter := self openExampleDropdown.

	aScripter
		substep: 'Execute examples locally'
		do: [ :aStep | 
			aStep click
				label: 'Click on run button';
				onSpaceRoot;
				id: GtPharoSuitePlayButtonId;
				play.

			self
				assertIn: aStep
				localToggleActive: true
				playEnabled: true
				withLabel: 'Run'.

			self
				assertIn: aStep
				exampleCountsOfAll: self numberOfExamples
				success: self numberOfExamples
				failure: 0
				error: 0
				notExecuted: 0 ].

	^ aScripter
]

{ #category : #'examples - example suite' }
GtPharoExampleSuiteExamples >> runExamplesRemotely [
	<gtExample>
	| aScripter |
	aScripter := self clickOnRemoteToggle.

	aScripter
		substep: 'Execute examples remotely'
		do: [ :aStep | 
			aStep click
				label: 'Click on run button';
				onSpaceRoot;
				id: GtPharoSuitePlayButtonId;
				play.

			self
				assertIn: aStep
				localToggleActive: false
				playEnabled: true
				withLabel: 'Run'.

			self
				assertIn: aStep
				exampleCountsOfAll: self numberOfExamples
				success: self numberOfExamples
				failure: 0
				error: 0
				notExecuted: 0 ].

	^ aScripter
]
