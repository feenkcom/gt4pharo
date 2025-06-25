"
I represent a {{gtClass:TestCase}} for a particular {{gtClass:GtPharoMethodCoder}}.
I keep a {{gtClass:TestResult}} and define the test case execution state using {{gtClass:GtPharoMethodTestCaseState}}.
#Examples
##Not Executed Test Case
The following example shows a *not* executed test case method: {{gtExample:GtPharoMethodTestCaseExamples >> #passedOneUnitTestPharoMethodCoder | codeExpanded=false | previewExpanded=true | previewShow=#gtLiveFor: | previewHeight=120}}
##Executed Test Case
The following example shows a executed test case method: {{gtExample:GtPharoMethodTestCaseExamples >> #executePassingTestCase | codeExpanded=false | previewExpanded=true | previewShow=#gtLiveFor: | previewHeight=120}}
##Modified Test Case Method
The following example shows that if we modify code, the test case state indicator changes: {{gtExample:GtPharoMethodTestCaseExamples >> #editExecutePassedTestCaseCode | codeExpanded=false | previewExpanded=true | previewShow=#gtLiveFor: | previewHeight=120}}
The test case state indicator can also dissapear if a method is identified as invalid test case (missing `test` method name prefix in this case): {{gtExample:GtPharoMethodTestCaseExamples >> #editTestCaseMethodName | codeExpanded=false | previewExpanded=true | previewShow=#gtLiveFor: | previewHeight=120}}
"
Class {
	#name : #GtPharoMethodTestCase,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'method',
		'result',
		'state'
	],
	#category : #'GToolkit-Pharo-TestSuite-Base'
}

{ #category : #'instance creation' }
GtPharoMethodTestCase class >> forMethod: aCompiledMethod [
	^ self new method: aCompiledMethod
]

{ #category : #'api - announcer' }
GtPharoMethodTestCase >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
]

{ #category : #'api - state' }
GtPharoMethodTestCase >> beSkipped [
	self state beSkipped: self
]

{ #category : #'api - accessing' }
GtPharoMethodTestCase >> behavior [
	^ method methodClass
]

{ #category : #'api - testing' }
GtPharoMethodTestCase >> canExecute [
	^ GtPharoTestCaseUtility canExecuteTestCase: method
]

{ #category : #'api - accessing' }
GtPharoMethodTestCase >> compiledMethod [
	<return: #CompiledMethod>
	^ method
]

{ #category : #'api - execution' }
GtPharoMethodTestCase >> debug [
	self rawDebug
]

{ #category : #accessing }
GtPharoMethodTestCase >> gtPharoMethodTestCase [
	^ self
]

{ #category : #'api - testing' }
GtPharoMethodTestCase >> hasNoTestPragma [
	^ self compiledMethod hasPragmaNamed: #noTest
]

{ #category : #'api - testing' }
GtPharoMethodTestCase >> hasResult [
	^ self result isNotNil
]

{ #category : #initialization }
GtPharoMethodTestCase >> initialize [
	super initialize.

	state := GtPharoMethodNotExecutedState.
]

{ #category : #'api - testing' }
GtPharoMethodTestCase >> isError [

	^ self hasResult and: [ 
		  self result
			  isErrorFor: self behavior
			  selector: self methodSelector ]
]

{ #category : #'api - testing' }
GtPharoMethodTestCase >> isFailure [

	^ self hasResult and: [ 
		  self result
			  isFailureFor: self behavior
			  selector: self methodSelector ]
]

{ #category : #testing }
GtPharoMethodTestCase >> isGtExample [

	^ false
]

{ #category : #'api - testing' }
GtPharoMethodTestCase >> isPassed [

	^ self hasResult and: [ 
		  self result
			  isPassedFor: self behavior
			  selector: self methodSelector ]
]

{ #category : #testing }
GtPharoMethodTestCase >> isSUnitTestCase [

	^ true
]

{ #category : #'api - testing' }
GtPharoMethodTestCase >> isSkipped [

	^ self hasResult and: [ self result skippedCount isZero not ]
]

{ #category : #initialization }
GtPharoMethodTestCase >> method: aCompiledMethod [
	method := aCompiledMethod.
	self subscribeToCompiledMethod
]

{ #category : #'api - accessing' }
GtPharoMethodTestCase >> methodSelector [
	^ method selector
]

{ #category : #'private - notifications' }
GtPharoMethodTestCase >> notifyResultChanged [

	self announce: (GtPharoMethodTestResultChanged new
			 testCase: self;
			 result: self result)
]

{ #category : #'private - notifications' }
GtPharoMethodTestCase >> notifyStateChanged [
	self announce: (GtPharoMethodTestCaseStateChanged new
		testCase: self;
		state: self state)
]

{ #category : #'private - event handling' }
GtPharoMethodTestCase >> onMethodModified: aMethodModifedAnnouncement [
	(aMethodModifedAnnouncement affectsMethod: method)
		ifFalse: [ ^ self ].
	self updateState
]

{ #category : #'api - execution' }
GtPharoMethodTestCase >> play [
	self rawPlay
]

{ #category : #'private - execution' }
GtPharoMethodTestCase >> rawDebug [
	| newResult testCase |
	newResult := nil.
	testCase := self testCaseInstance.
	[ 
		self withStackOverflowCheckExecute: [
			testCase setUp.
			[
				testCase tests do: [:each |
					newResult := testCase resultClass new.
					self withStackOverflowCheckExecute:[
						each debug: newResult ].
					testCase announceTest: each.
					testCase changed: each]
			] ensure: [testCase tearDown] ].
	] ensure: [
		self result: (newResult ifNil: [
			testCase resultClass new ]) ]
]

{ #category : #'private - execution' }
GtPharoMethodTestCase >> rawPlay [
	self result: (self 
		withStackOverflowCheckExecute: [ self testCaseInstance run] )
]

{ #category : #'api - accessing' }
GtPharoMethodTestCase >> result [
	<return: #TestResult>

	^ result
]

{ #category : #'api - accessing' }
GtPharoMethodTestCase >> result: aTestResult [ 
	result := aTestResult.
	self updateState.
	self notifyResultChanged.
]

{ #category : #'api - accessing' }
GtPharoMethodTestCase >> state [
	<return: #GtPharoMethodTestCaseState>

	^ state
]

{ #category : #'api - accessing' }
GtPharoMethodTestCase >> state: aState [ 
	state == aState
		ifTrue: [ ^ self ].
	state := aState.
	self notifyStateChanged
]

{ #category : #'api - accessing' }
GtPharoMethodTestCase >> stateLabel [
	^ self state label
]

{ #category : #'private - subscriptions' }
GtPharoMethodTestCase >> subscribeToCompiledMethod [
	"SystemAnnouncer uniqueInstance weak
		when: MethodModified send: #onMethodModified: to: self"
]

{ #category : #'api - accessing' }
GtPharoMethodTestCase >> testCaseInstance [

	^ GtPharoMethodTestSuiteBuilder new
		behavior: self behavior;
		selector: self methodSelector;
		build
]

{ #category : #'api - announcer' }
GtPharoMethodTestCase >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'private - subscriptions' }
GtPharoMethodTestCase >> unsubscribeFromCompiledMethod [
	"SystemAnnouncer uniqueInstance unsubscribe: self"
]

{ #category : #'private - updating' }
GtPharoMethodTestCase >> updateState [

	self canExecute ifFalse: [ 
		^ self state: GtPharoMethodNotExecutableTestCaseState ].
	self hasResult ifFalse: [
		^ self state: GtPharoMethodNotExecutedState ].
	self state: (GtPharoMethodTestCaseState stateFromTestResult: self result)
]

{ #category : #'api - announcer' }
GtPharoMethodTestCase >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPharoMethodTestCase >> when: anAnnouncementClass do: aBlock for: aSubscriber [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoForTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock for: aSubscriber
]

{ #category : #'api - announcer' }
GtPharoMethodTestCase >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]

{ #category : #'private - execution' }
GtPharoMethodTestCase >> withStackOverflowCheckExecute: aBlock [
	^ GtProcessStackOverflowChecker currentCheckerClass 
		checkDuring: aBlock
]
