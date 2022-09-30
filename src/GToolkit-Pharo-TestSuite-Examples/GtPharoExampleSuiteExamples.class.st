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
				format: {aBoolean ifTrue: [ 'with a non-zero ammount' ] ifFalse: [ 'with zero amount' ]});
		satisfies: [ :aStateAmountLabel | aStateAmountLabel text asString ~= '0' = aBoolean ];
		onSpaceRoot;
		id: (GtPharoSuiteStateId new state: GtFilterExampleAllState uniqueInstance);
		id: GtPharoSuiteStateAmountLabelId;
		play
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
	aScripter := self scripterForBlock: [ GtCoder forClass: self class ].

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

			self assertIn: aStep allExamplesWithSomeExamples: true ].

	^ aScripter
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
				flag: 'The idea is that the list with example states should be properly filled with numbers.
		I suspect that the following wait steps does not target it properly 
		and it is only coincidence that it works'.

			aStep wait
				forEnqueuedSpaceTaskTimeout: 3 seconds;
				play.
			aStep wait
				forEmptySpaceTaskQueue;
				play.

			self
				assertIn: aStep
				localToggleActive: true
				playEnabled: true
				withLabel: 'Run'.

			self assertIn: aStep allExamplesWithSomeExamples: true ].

	^ aScripter
]
