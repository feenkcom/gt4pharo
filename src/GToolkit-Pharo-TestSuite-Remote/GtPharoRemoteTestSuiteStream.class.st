"
GtPharoRemoteTestSuiteStream takes an AsyncStream of {{gtClass:GtPharoMethodTestCase}}s and runs the tests using {{gtClass:GtRemoteRunner}} providing the results as an AsyncStream of updated {{gtClass:GtPharoMethodTestCase}}s.
"
Class {
	#name : #GtPharoRemoteTestSuiteStream,
	#superclass : #Object,
	#traits : 'TAsyncStream',
	#classTraits : 'TAsyncStream classTrait',
	#instVars : [
		'sourceStream',
		'job',
		'tests',
		'jobCompleted',
		'results',
		'waker'
	],
	#category : #'GToolkit-Pharo-TestSuite-Remote'
}

{ #category : #'instance creation' }
GtPharoRemoteTestSuiteStream class >> startOnSourceStream: sourceStream [

	^ self new
		sourceStream: sourceStream;
		start
]

{ #category : #initialization }
GtPharoRemoteTestSuiteStream >> initialize [

	super initialize.
	jobCompleted := false.
	results := SharedQueue new.
	waker := AsyncFutureExecutionAtomicWaker new.
]

{ #category : #private }
GtPharoRemoteTestSuiteStream >> onJobCancelledAnnouncement: anAnnouncement [
	"This currently just marks the job as completed.
	It means that the result stream won't include unfinished tasks, so the Coder won't be updated.
	The incomplete tests should be marked as Error with an explanation.  TBD after we switch from GtPharoMethodTestCase to PharoLinkTestCaseEndAnnouncements."

	jobCompleted := true.
]

{ #category : #private }
GtPharoRemoteTestSuiteStream >> onJobCompletedAnnouncement: anAnnouncement [

	jobCompleted := true.

]

{ #category : #private }
GtPharoRemoteTestSuiteStream >> onJobTerminatedAnnouncement: anAnnouncement [
	"This currently just marks the job as completed.
	It means that the result stream won't include unfinished tasks, so the Coder won't be updated.
	The incomplete tests should be marked as Error with an explanation.  TBD after we switch from GtPharoMethodTestCase to PharoLinkTestCaseEndAnnouncements."

	jobCompleted := true.
]

{ #category : #private }
GtPharoRemoteTestSuiteStream >> onTaskCompletedAnnouncement: anAnnouncement [
	| testResult testName gtTestCase |
	anAnnouncement taskResult do: [ :taskResult | 
		taskResult isSUnitTestCase
			ifTrue: [ testResult := TestResult new.
				testName := taskResult testCaseClass name -> taskResult testCaseSelector.
				gtTestCase := tests at: testName.
				taskResult
					populateTestResult: testResult
					with: (taskResult testCaseClass selector: taskResult testCaseSelector).
				gtTestCase result: testResult.	
				"Then put on the queue ready to answer in the output stream."
				results nextPut: (AsyncPoll ready: (AsyncOptionalValue some: gtTestCase)) ]
			ifFalse: [ taskResult isGtExample ifTrue: 
				[ testName := taskResult testCaseClassName -> taskResult testCaseSelector.
				gtTestCase := tests at: testName.
				gtTestCase result: (GtExampleResult new
					example: gtTestCase example;
					returnValue: taskResult asGtExampleResult).
				taskResult asGtExampleResult.
				results nextPut: (AsyncPoll ready: (AsyncOptionalValue some: gtTestCase)) ]
			ifFalse: 
				[ self error: 'Unknown result type' ] ].
			waker wakeUp ]
]

{ #category : #private }
GtPharoRemoteTestSuiteStream >> onTaskFailedAnnouncement: anAnnouncement [

	Stdio stdout
		<< 'GtPharoRemoteTestSuiteStream>>onTaskFailedAnnouncement:'; lf.
	self notYetImplemented.

]

{ #category : #'api - stream' }
GtPharoRemoteTestSuiteStream >> pollNext: anAsynchronousContext [
	"Attempt to pull out the next value of this stream, registering the current task for wakeup if the value is not yet available, and returning None if the stream is exhausted.
	There are several possible return values, each indicating a distinct stream state:
	 - Poll::Pending means that this stream's next value is not ready yet. Implementations will ensure that the current task will be notified when the next value may be ready.
	 - Poll::Ready(Some(val)) means that the stream has successfully produced a value, val, and may produce further values on subsequent poll_next calls.
	 - Poll::Ready(None) means that the stream has terminated, and poll_next should not be invoked again."
	<return: #AsyncPoll>
	| result |

	(jobCompleted and: [ results isEmpty ]) ifTrue: [ ^ AsyncPoll ready: AsyncOptionalValue none ].
	waker register: anAsynchronousContext waker.

	result := results nextOrNil ifNil: [ AsyncPoll pending ].
	Stdio stdout 
		print: Time now;
		<< ' ';
		print: result; lf.
	^ result.
]

{ #category : #initialization }
GtPharoRemoteTestSuiteStream >> postSimilarCopy [
	"Is called by similarCopy. self is a shallow copy, implementors should set the fields as necessary to complete the similar copy"
	
	waker := AsyncFutureExecutionAtomicWaker new.
	sourceStream := sourceStream asyncSimilarCopy
]

{ #category : #initialization }
GtPharoRemoteTestSuiteStream >> reset [

	tests := Dictionary new.
]

{ #category : #accessing }
GtPharoRemoteTestSuiteStream >> sourceStream [

	^ sourceStream
]

{ #category : #accessing }
GtPharoRemoteTestSuiteStream >> sourceStream: anObject [

	sourceStream := anObject
]

{ #category : #'start-stop' }
GtPharoRemoteTestSuiteStream >> start [
	"Read all the tests to be run and submit them to the default RemoteRunner.
	Tests are grouped based on an average execution time, see {{gtClass:GtRrAverageTimeExampleAllocator}}."
	| testNames exampleNames testRegistrationStream |

	self reset.
	testNames := OrderedCollection new.
	exampleNames := OrderedCollection new.
	testRegistrationStream := sourceStream forEach: [ :anExample |
		| method testName |
		anExample isGtExample ifTrue:
			[ testName := anExample example methodClass name ->
				anExample example selector.
			tests at: testName put: anExample.
			exampleNames add: testName ]
		ifFalse: [ anExample isSUnitTestCase ifTrue:
			[ method := anExample compiledMethod.
			testName := method methodClass name -> method selector.
			"Store the test case so it can be given the result after the test has been run"
			tests at: testName put: anExample.
			testNames add: testName ]
		ifFalse: [ Stdio stdout << '*** Async thingy error'; lf.
			self error: 'Unknown example type' ] ] ].
	testRegistrationStream wait.
	job := GtRrChecksFactory new 
		addSUnitTestNames: testNames;
		addExampleTestNames: exampleNames;
		setNotInImage;
		groupTasksByAverageTime;
		job.
	job
		showExamplesProgressNotification;
		when: GtRrTaskCompletedAnnouncement 
			send: #onTaskCompletedAnnouncement: 
			to: self;
		when: GtRrTaskFailedAnnouncement 
			send: #onTaskFailedAnnouncement: 
			to: self;
		when: GtRrJobCancelledAnnouncement
			send: #onJobCancelledAnnouncement:
			to: self;
		when: GtRrJobCompletedAnnouncement
			send: #onJobCompletedAnnouncement:
			to: self;
		when: GtRrJobTerminatedAnnouncement
			send: #onJobTerminatedAnnouncement:
			to: self.
	job := GtRemoteRunner default submitJob: job.
]
