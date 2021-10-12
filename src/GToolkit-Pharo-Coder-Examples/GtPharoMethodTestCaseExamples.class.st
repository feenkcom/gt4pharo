Class {
	#name : #GtPharoMethodTestCaseExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Test Case'
}

{ #category : #asserting }
GtPharoMethodTestCaseExamples >> assertUnexecutedTestCaseOfCoder: aCoder [

	self assert: aCoder testCase isFailure not description: [ 
		aCoder compiledMethod asString
		, ' cannot be a failed test case as it was not executed' ].

	self assert: aCoder testCase isError not description: [ 
		aCoder compiledMethod asString
		, ' cannot be a errored test case as it was not executed' ].

	self assert: aCoder testCase isSkipped not description: [ 
		aCoder compiledMethod asString
		, ' cannot be a skipped test case as it was not executed' ]
]

{ #category : #'examples - test case' }
GtPharoMethodTestCaseExamples >> basicTestCase [
	<gtExample>
	| aTestCase |
	aTestCase := GtPharoMethodTestCase new.
	
	self assert: aTestCase canExecute not description: [ 'Uninitialized test case cannot be executed' ].
	
	^ aTestCase
]

{ #category : #'examples - test case' }
GtPharoMethodTestCaseExamples >> emptyPharoMethodCoder [

	<gtExample>
	| aCoder |
	aCoder := GtPharoMethodCoder new.

	self
		assert: aCoder testCase canExecute not
		description: [ 
		'Uninitialized method coder cannot execute test cases' ].
	self assertUnexecutedTestCaseOfCoder: aCoder.

	^ aCoder
]

{ #category : #'examples - test case' }
GtPharoMethodTestCaseExamples >> examplePharoMethodCoder [

	<gtExample>
	^ self
		  initializeCoderWith: self class >> #foo
		  executable: false
]

{ #category : #'examples - mocks' }
GtPharoMethodTestCaseExamples >> foo [
	^ 42
]

{ #category : #'examples - test case' }
GtPharoMethodTestCaseExamples >> initializeCoderWith: aCompiledMethod executable: aBoolean [

	<gtExample>
	| aCoder |
	aCoder := GtPharoMethodCoder forMethod: aCompiledMethod.

	self
		assert: aCoder testCase canExecute = aBoolean
		description: [ 
		aCompiledMethod asString , ' should be executed as a test case' ].

	self assert: aCoder testCase isPassed not description: [ 
		aCompiledMethod asString
		, ' cannot be a successful test case as it was not executed' ].

	self assertUnexecutedTestCaseOfCoder: aCoder.

	^ aCoder
]

{ #category : #'examples - test case' }
GtPharoMethodTestCaseExamples >> nonUnitTestPharoMethodCoder [

	<gtExample>
	
	^ self
		  initializeCoderWith: GtPharoDummyTestCase >> #setUp
		  executable: false
]

{ #category : #'examples - test case' }
GtPharoMethodTestCaseExamples >> passedOneUnitTestPharoMethodCoder [

	<gtExample>
	^ self
		  initializeCoderWith: GtPharoDummyTestCase >> #testPassedOne
		  executable: true
]
