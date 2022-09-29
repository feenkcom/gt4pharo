Class {
	#name : #GtPharoExampleSuiteExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : #'GToolkit-Pharo-TestSuite-Examples'
}

{ #category : #'examples - example suite' }
GtPharoExampleSuiteExamples >> classCoderWithExampleMethods [
	<gtExample>
	| aScripter |
	aScripter := self scripterForBlock: [ GtCoder forClass: self class ].

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

			aStep assert
				label: 'Play button is enabled and with "Run" label';
				satisfies: [ :aPlayButton | aPlayButton isEnabled and: [ aPlayButton label asString = 'Run' ] ];
				onSpaceRoot;
				id: GtPharoSuitePlayButtonId;
				play.

			aStep assert
				label: 'Local toggle is enabled and activated';
				satisfies: [ :aToggle | aToggle isEnabled and: [ aToggle isActivated ] ];
				onSpaceRoot;
				id: GtPharoSuiteLocalToggleId;
				play.

			aStep assert
				label: 'Remote toggle is enabled and inactivated';
				satisfies: [ :aToggle | aToggle isEnabled and: [ aToggle isActivated not ] ];
				onSpaceRoot;
				id: GtPharoSuiteRemoteToggleId;
				play.

			aStep assert
				label: 'All examples overview is visible with a non-zero number';
				satisfies: [ :aStateAmountLabel | aStateAmountLabel text asString ~= '0' ];
				onSpaceRoot;
				id: (GtPharoSuiteStateId new state: GtFilterExampleAllState uniqueInstance);
				id: GtPharoSuiteStateAmountLabelId;
				play ].

	^ aScripter
]

{ #category : #accessing }
GtPharoExampleSuiteExamples >> methodsCoderWithExampleMethods [
	<gtExample>
	
]
