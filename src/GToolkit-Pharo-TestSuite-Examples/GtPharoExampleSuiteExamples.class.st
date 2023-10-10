Class {
	#name : #GtPharoExampleSuiteExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : #'GToolkit-Pharo-TestSuite-Examples'
}

{ #category : #'examples - example suite' }
GtPharoExampleSuiteExamples >> assertIn: aParentStep exampleCountsOfAll: allCount success: successCount failure: failureCount error: errorCount notExecuted: notExecutedCount [
	<gtExample>
	aParentStep
		checks: 'Assert displayed example results'
		do: [ :aStep | 
			aStep
				assertStep: [ :s | 
					s
						label: 'All examples label';
						satisfies: [ :aStateAmountLabel | aStateAmountLabel text asString = allCount asString ];
						onSpaceRoot;
						id: (GtPharoSuiteStateId new state: GtFilterExampleAllState uniqueInstance);
						id: GtPharoSuiteStateAmountLabelId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Success examples label';
						satisfies: [ :aStateAmountLabel | aStateAmountLabel text asString = successCount asString ];
						onSpaceRoot;
						id: (GtPharoSuiteStateId new state: GtFilterExampleSuccessState uniqueInstance);
						id: GtPharoSuiteStateAmountLabelId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Failure examples label';
						satisfies: [ :aStateAmountLabel | aStateAmountLabel text asString = failureCount asString ];
						onSpaceRoot;
						id: (GtPharoSuiteStateId new state: GtFilterExampleFailureState uniqueInstance);
						id: GtPharoSuiteStateAmountLabelId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Error examples label';
						satisfies: [ :aStateAmountLabel | aStateAmountLabel text asString = errorCount asString ];
						onSpaceRoot;
						id: (GtPharoSuiteStateId new state: GtFilterExampleErrorState uniqueInstance);
						id: GtPharoSuiteStateAmountLabelId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Not executed examples label';
						satisfies: [ :aStateAmountLabel | aStateAmountLabel text asString = notExecutedCount asString ];
						onSpaceRoot;
						id: (GtPharoSuiteStateId new state: GtFilterExampleNotExecutedState uniqueInstance);
						id: GtPharoSuiteStateAmountLabelId ] ]
]

{ #category : #'examples - example suite' }
GtPharoExampleSuiteExamples >> assertIn: aStep localToggleActive: localActivated playEnabled: playIsEnabled withLabel: playLabel [
	<gtExample>
	aStep
		assertStep: [ :s | 
			s
				label: ('Play button is {1} with label "{2}"'
						format: {playIsEnabled ifTrue: [ 'enabled' ] ifFalse: [ 'disabled' ].
								playLabel});
				satisfies: [ :aPlayButton | 
					aPlayButton isEnabled = playIsEnabled
						and: [ aPlayButton label asString = playLabel ] ];
				onSpaceRoot;
				id: GtPharoSuitePlayButtonId ].

	aStep
		assertStep: [ :s | 
			s
				label: ('Local toggle is enabled and {1}'
						format: {localActivated ifTrue: [ 'actived' ] ifFalse: [ 'inactivated' ]});
				satisfies: [ :aToggle | aToggle isEnabled and: [ aToggle isActivated = localActivated ] ];
				onSpaceRoot;
				id: GtPharoSuiteLocalToggleId ].

	aStep
		assertStep: [ :s | 
			s
				label: ('Remote toggle is enabled and {1}'
						format: {localActivated ifFalse: [ 'actived' ] ifTrue: [ 'inactivated' ]});
				satisfies: [ :aToggle | aToggle isEnabled and: [ aToggle isActivated = localActivated not ] ];
				onSpaceRoot;
				id: GtPharoSuiteRemoteToggleId ].

	aStep
		assertStep: [ :s | 
			s
				label: ('Suite view model with {1} executor'
						format: {localActivated ifTrue: [ 'local' ] ifFalse: [ 'remote' ]});
				satisfies: [ :aScripter | (aScripter userData at: #suiteViewModel) isLocal = localActivated ];
				onScripter ]
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
				GtCoderElement forClass: aClass ].

	aScripter set
		label: 'Store suite view model';
		key: #suiteViewModel value: [ :aButton | aButton suiteViewModel ];
		id: GtPharoExampleSuiteShowButtonId;
		play.

	aScripter
		checks: 'Initial state assertions'
		do: [ :aStep | 
			aStep
				assertStep: [ :s | 
					s
						label: 'Assert example button exists';
						exists;
						id: GtPharoExampleSuiteShowButtonId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Example button is enabled and visible';
						satisfies: [ :aButton | aButton isEnabled and: [ aButton visibility = BlVisibility visible ] ];
						id: GtPharoExampleSuiteShowButtonId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Test button is gone';
						satisfies: [ :aButton | aButton visibility = BlVisibility gone ];
						id: GtPharoTestSuiteShowButtonId ] ].

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
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on remote toggle';
						onSpaceRoot;
						id: GtPharoSuiteRemoteToggleId ].

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

{ #category : #'examples - example suite' }
GtPharoExampleSuiteExamples >> closeDropdownWithLocallyExecutedExamples [
	<gtExample>
	| aScripter |
	aScripter := self runExamplesLocally.

	aScripter
		substep: 'Close example dropdown'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click class name';
						id: GtBehaviorCoderBehaviorNameId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Local toggle does not exist';
						notExists;
						id: GtPharoSuiteLocalToggleId ] ].

	^ aScripter
]

{ #category : #'examples - example suite' }
GtPharoExampleSuiteExamples >> closeDropdownWithRemoteToggleSelected [
	<gtExample>
	| aScripter |
	aScripter := self clickOnRemoteToggle.

	aScripter
		substep: 'Close example dropdown'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click class name';
						id: GtBehaviorCoderBehaviorNameId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Remote toggle does not exist';
						notExists;
						id: GtPharoSuiteRemoteToggleId ] ].

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
		substep: 'Display example dropdown'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on example button';
						id: GtPharoExampleSuiteShowButtonId ].

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
GtPharoExampleSuiteExamples >> reopenExampleDropdownWithLocallyExecutedExamples [
	<gtExample>
	| aScripter |
	aScripter := self closeDropdownWithLocallyExecutedExamples.

	aScripter
		substep: 'Display example Dropdown'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on example button';
						id: GtPharoExampleSuiteShowButtonId ].

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
GtPharoExampleSuiteExamples >> reopenExampleDropdownWithRemoteToggleSelected [
	<gtExample>
	<noTest>
	| aScripter |
	aScripter := self closeDropdownWithRemoteToggleSelected.

	aScripter
		substep: 'Display example dropdown'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on example button';
						id: GtPharoExampleSuiteShowButtonId ].

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

{ #category : #'examples - example suite' }
GtPharoExampleSuiteExamples >> runExamplesLocally [
	<gtExample>
	| aScripter |
	aScripter := self openExampleDropdown.

	aScripter
		substep: 'Execute examples locally'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on run button';
						onSpaceRoot;
						id: GtPharoSuitePlayButtonId ].

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
	<noTest>
	| aScripter |
	aScripter := self clickOnRemoteToggle.

	aScripter
		substep: 'Execute examples remotely'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on run button';
						onSpaceRoot;
						id: GtPharoSuitePlayButtonId ].

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
