Class {
	#name : #GtPharoRemoteTestSuiteStreamExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'GToolkit-Pharo-TestSuite-Examples'
}

{ #category : #examples }
GtPharoRemoteTestSuiteStreamExamples >> runGtRrSampleTest [
	<gtExample>
	| selectors inputStream resultStream passCount failCount errorCount results testedSelectors |

	selectors := #(testPass testFail testError testLong).
	inputStream := (selectors collect: [ :each |
		GtPharoMethodTestCase forMethod: GtRrSampleTest >> each ]) asAsyncStream.
	resultStream := GtPharoRemoteTestSuiteStream startOnSourceStream: inputStream.
	passCount := failCount := errorCount := 0.
	testedSelectors := OrderedCollection new.
self halt.
	results := resultStream forEach: [ :gtTestCase |
		testedSelectors add: gtTestCase methodSelector.
		passCount := passCount + gtTestCase result passedCount.
		failCount := failCount + gtTestCase result failureCount.
		errorCount := errorCount + gtTestCase result errorCount ].
	results wait.
	self assert: testedSelectors asSet equals: selectors asSet.
	"If the tests in GtRrSampleTest are marked expectedFailure all will be counted as a pass"
	"self assert: passCount equals: 4.
	self assert: failCount equals: 0.
	self assert: errorCount equals: 0."
	"if the tests in GrRrSampleTest aren't expectedFailure:"
	self assert: passCount equals: 1.
	self assert: failCount equals: 1.
	self assert: errorCount equals: 2.

	^ resultStream
]
