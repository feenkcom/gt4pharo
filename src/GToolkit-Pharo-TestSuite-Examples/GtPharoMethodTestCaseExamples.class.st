"
I exemplify {{gtClass:GtPharoMethodTestCase}}.

"
Class {
	#name : #GtPharoMethodTestCaseExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-TestSuite-Examples'
}

{ #category : #asserting }
GtPharoMethodTestCaseExamples >> assertNotExecutableTestCaseOfCoder: aCoder [

	self assert: aCoder testCase isFailure not description: [ 
		aCoder compiledMethod asString
		, ' cannot be a failed test case as it was not executed' ].

	self assert: aCoder testCase isError not description: [ 
		aCoder compiledMethod asString
		, ' cannot be a errored test case as it was not executed' ].

	self assert: aCoder testCase isSkipped not description: [ 
		aCoder compiledMethod asString
		, ' cannot be a skipped test case as it was not executed' ].
		
	self
		assert: aCoder testCase state
		equals: GtPharoMethodNotExecutableTestCaseState.

]

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
		, ' cannot be a skipped test case as it was not executed' ].
		
	self
		assert: aCoder testCase state isNotNil
		description: [ 
			aCoder compiledMethod asString 
			, ' must have a test case state' ].
]

{ #category : #'examples - test case' }
GtPharoMethodTestCaseExamples >> basicTestCase [
	<gtExample>
	| aTestCase |
	aTestCase := GtPharoMethodTestCase new.
	
	self assert: aTestCase canExecute not description: [ 'Uninitialized test case cannot be executed' ].
	
	^ aTestCase
]

{ #category : #'examples - execution' }
GtPharoMethodTestCaseExamples >> cleanOneUnitTestCache [
	<gtExample>
	| aMethod |
	aMethod := GtPharoDummyTestCase >> #testPassedOne.
	aMethod clearExampleAndTestCaches.
	
	self assert: aMethod isNotNil.
	
	^ aMethod
]

{ #category : #'examples - execution' }
GtPharoMethodTestCaseExamples >> editExecutePassedTestCaseCode [
	<gtExample>
	| aCoder |
	aCoder := self executePassingTestCase.
	aCoder deleteSourceTextFrom: 63 to: 66.

	self assert: aCoder testCase result isNotNil.
	self assert: aCoder testCase state isNotNil.
	self assert: aCoder testCase isPassed.
	self
		assert: aCoder testCase state
		equals: GtPharoMethodTestCasePassedState.

	^ aCoder
]

{ #category : #'examples - execution' }
GtPharoMethodTestCaseExamples >> editTestCaseMethodName [
	<gtExample>
	| aCoder |
	aCoder := self executePassingTestCase.
	aCoder deleteSourceTextFrom: 2 to: 4.

	self assert: aCoder testCase result isNotNil.
	self assert: aCoder testCase state isNotNil.
	self assert: aCoder testCase isPassed.
	self
		assert: aCoder testCase state
		equals: GtPharoMethodTestCasePassedState.

	^ aCoder
]

{ #category : #'examples - test case' }
GtPharoMethodTestCaseExamples >> emptyPharoMethodCoder [
	<gtExample>
	| aCoder |
	aCoder := GtPharoMethodCoder new.

	self
		assert: aCoder testCase isNil
		description: [ 'Uninitialized method coder cannot have test cases' ].

	^ aCoder
]

{ #category : #'examples - test case' }
GtPharoMethodTestCaseExamples >> examplePharoMethodCoder [
	<gtExample>
	^ self initializeCoderWith: self class >> #foo executable: false
]

{ #category : #'examples - execution' }
GtPharoMethodTestCaseExamples >> executePassingTestCase [
	<gtExample>
	| aCoder allAnnouncements |
	self cleanOneUnitTestCache.
	aCoder := self passedOneUnitTestPharoMethodCoder.
	allAnnouncements := OrderedCollection new.
	aCoder testCase when: Announcement send: #add: to: allAnnouncements.
	
	aCoder testCase play.

	self assert: aCoder testCase result isNotNil.
	self assert: aCoder testCase isPassed.
	self assert: aCoder testCase state isNotNil.
	self
		assert: aCoder testCase state
		equals: GtPharoMethodTestCasePassedState.
	self assert: allAnnouncements size equals: 2.
	self assert: allAnnouncements first class equals: GtPharoMethodTestCaseStateChanged.
	self assert: allAnnouncements second class equals: GtPharoMethodTestResultChanged.
	
	^ aCoder
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

	aBoolean ifFalse: [ 
		self assert: aCoder testCase isNil 
		description: [ aCompiledMethod asString , ' should not return a test case' ].
		^ aCoder ].
	
	self
		assert: aCoder testCase canExecute = aBoolean
		description: [ 
		aCompiledMethod asString , ' should be executed as a test case' ].

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
	^ (self
		  initializeCoderWith: GtPharoDummyTestCase >> #testPassedOne
		  executable: true)
]
