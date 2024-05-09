Class {
	#name : #GtPharoTestSuiteExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : #'GToolkit-Pharo-TestSuite-Examples'
}

{ #category : #'examples - example suite' }
GtPharoTestSuiteExamples >> assertIn: aStep localToggleActive: localActivated playEnabled: playIsEnabled withLabel: playLabel [
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
GtPharoTestSuiteExamples >> assertIn: aParentStep testCaseCountsOfAll: allCount passed: passedCount skipped: skippedCount failure: failureCount error: errorCount notExecuted: notExecutedCount [
	<gtExample>
	aParentStep
		checks: 'Assert displayed example results'
		do: [ :aStep | 
			aStep
				assertStep: [ :s | 
					s
						label: 'All test case label';
						satisfies: [ :aStateAmountLabel | aStateAmountLabel text asString = allCount asString ];
						onSpaceRoot;
						id: (GtPharoSuiteStateId new state: GtPharoMethodTestCaseAllState);
						id: GtPharoSuiteStateAmountLabelId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Passed test case label';
						satisfies: [ :aStateAmountLabel | aStateAmountLabel text asString = passedCount asString ];
						onSpaceRoot;
						id: (GtPharoSuiteStateId new state: GtPharoMethodTestCasePassedState);
						id: GtPharoSuiteStateAmountLabelId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Skipped test case label';
						satisfies: [ :aStateAmountLabel | aStateAmountLabel text asString = skippedCount asString ];
						onSpaceRoot;
						id: (GtPharoSuiteStateId new state: GtPharoMethodTestCaseSkippedState);
						id: GtPharoSuiteStateAmountLabelId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Failure test case label';
						satisfies: [ :aStateAmountLabel | aStateAmountLabel text asString = failureCount asString ];
						onSpaceRoot;
						id: (GtPharoSuiteStateId new state: GtPharoMethodTestCaseFailureState);
						id: GtPharoSuiteStateAmountLabelId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Error test case label';
						satisfies: [ :aStateAmountLabel | aStateAmountLabel text asString = errorCount asString ];
						onSpaceRoot;
						id: (GtPharoSuiteStateId new state: GtPharoMethodTestCaseErrorState);
						id: GtPharoSuiteStateAmountLabelId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Not executed test case label';
						satisfies: [ :aStateAmountLabel | aStateAmountLabel text asString = notExecutedCount asString ];
						onSpaceRoot;
						id: (GtPharoSuiteStateId new state: GtPharoMethodNotExecutedState);
						id: GtPharoSuiteStateAmountLabelId ] ]
]

{ #category : #'examples - example suite' }
GtPharoTestSuiteExamples >> classCoderWithTestCaseMethods [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ | aClass |
				aClass := self classWithTestCases.
				aClass suite tests
					do: [ :aTestCase | aTestCase gtCompiledMethod clearExampleAndTestCaches ].
				GtCoderElement forClass: aClass ].

	aScripter set
		label: 'Store suite view model';
		key: #suiteViewModel value: [ :aButton | aButton suiteViewModel ];
		id: GtPharoTestSuiteShowButtonId;
		play.

	aScripter
		checks: 'Initial state assertions'
		do: [ :aStep | 
			aStep
				assertStep: [ :s | 
					s
						label: 'Assert test button exists';
						exists;
						id: GtPharoExampleSuiteShowButtonId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Test button is enabled and visible';
						satisfies: [ :aButton | aButton isEnabled and: [ aButton visibility = BlVisibility visible ] ];
						id: GtPharoTestSuiteShowButtonId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Example button is gone';
						satisfies: [ :aButton | aButton visibility = BlVisibility gone ];
						id: GtPharoExampleSuiteShowButtonId ] ].

	^ aScripter
]

{ #category : #'examples - dummy examples' }
GtPharoTestSuiteExamples >> classWithTestCases [
	<gtExample>
	^ GtPharoTestSuiteDummyTest
]

{ #category : #'examples - example suite' }
GtPharoTestSuiteExamples >> clickOnRemoteToggle [
	<gtExample>
	| aScripter |
	aScripter := self openTestCaseDropdown.

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
				testCaseCountsOfAll: self numberOfTestCases
				passed: 0
				skipped: 0
				failure: 0
				error: 0
				notExecuted: self numberOfTestCases ].

	^ aScripter
]

{ #category : #'examples - example suite' }
GtPharoTestSuiteExamples >> closeDropdownWithLocallyExecutedTestCases [
	<gtExample>
	| aScripter |
	aScripter := self runTestCasesLocally.

	aScripter
		substep: 'Close test case dropdown'
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
GtPharoTestSuiteExamples >> closeDropdownWithRemoteToggleSelected [
	<gtExample>
	| aScripter |
	aScripter := self clickOnRemoteToggle.

	aScripter
		substep: 'Close test case dropdown'
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
GtPharoTestSuiteExamples >> numberOfTestCases [
	<gtExample>
	| aCount |
	aCount := self classWithTestCases suite tests size.
	self
		assert: aCount isZero not
		description: [ '{1} must have test cases' format: {self classWithTestCases} ].

	^ aCount
]

{ #category : #'examples - example suite' }
GtPharoTestSuiteExamples >> openTestCaseDropdown [
	<gtExample>
	| aScripter |
	aScripter := self classCoderWithTestCaseMethods.

	aScripter
		substep: 'Display test dropdown'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on test button';
						id: GtPharoTestSuiteShowButtonId ].

			self
				assertIn: aStep
				localToggleActive: true
				playEnabled: true
				withLabel: 'Run'.

			self
				assertIn: aStep
				testCaseCountsOfAll: self numberOfTestCases
				passed: 0
				skipped: 0
				failure: 0
				error: 0
				notExecuted: self numberOfTestCases ].

	^ aScripter
]

{ #category : #'examples - example suite' }
GtPharoTestSuiteExamples >> reopenTestCaseDropdownWithLocallyExecutedTestCases [
	<gtExample>
	<noTest>
	| aScripter |
	aScripter := self closeDropdownWithLocallyExecutedTestCases.

	aScripter
		substep: 'Display test case dropdown'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on test case button';
						id: GtPharoTestSuiteShowButtonId ].

			self
				assertIn: aStep
				localToggleActive: true
				playEnabled: true
				withLabel: 'Run'.

			self
				assertIn: aStep
				testCaseCountsOfAll: self numberOfTestCases
				passed: self numberOfTestCases
				skipped: 0
				failure: 0
				error: 0
				notExecuted: 0 ].

	^ aScripter
]

{ #category : #'examples - example suite' }
GtPharoTestSuiteExamples >> reopenTestCaseDropdownWithRemoteToggleSelected [
	<gtExample>
	| aScripter |
	aScripter := self closeDropdownWithRemoteToggleSelected.

	aScripter
		substep: 'Display test suite dropdown'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on test suite button';
						id: GtPharoTestSuiteShowButtonId ].

			self
				assertIn: aStep
				localToggleActive: false
				playEnabled: true
				withLabel: 'Run'.

			self
				assertIn: aStep
				testCaseCountsOfAll: self numberOfTestCases
				passed: 0
				skipped: 0
				failure: 0
				error: 0
				notExecuted: self numberOfTestCases ].

	^ aScripter
]

{ #category : #'examples - example suite' }
GtPharoTestSuiteExamples >> runTestCasesLocally [
	<gtExample>
	| aScripter |
	aScripter := self openTestCaseDropdown.

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
				testCaseCountsOfAll: self numberOfTestCases
				passed: self numberOfTestCases
				skipped: 0
				failure: 0
				error: 0
				notExecuted: 0 ].

	^ aScripter
]

{ #category : #'examples - example suite' }
GtPharoTestSuiteExamples >> runTestCasesRemotely [
	<gtExample>
	| aScripter |
	aScripter := self clickOnRemoteToggle.

	aScripter
		substep: 'Execute test cases remotely'
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
				testCaseCountsOfAll: self numberOfTestCases
				passed: self numberOfTestCases
				skipped: 0
				failure: 0
				error: 0
				notExecuted: 0 ].

	^ aScripter
]
