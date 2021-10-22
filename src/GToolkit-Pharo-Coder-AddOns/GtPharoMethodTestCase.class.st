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
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'methodCoder',
		'result',
		'state',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #'instance creation' }
GtPharoMethodTestCase class >> forMethodCoder: aMethodCoder [

	^ self new methodCoder: aMethodCoder
]

{ #category : #accessing }
GtPharoMethodTestCase >> announcer [
	^ announcer
]

{ #category : #'api - state' }
GtPharoMethodTestCase >> beSkipped [
	self state beSkipped: self
]

{ #category : #'accessing - coder' }
GtPharoMethodTestCase >> behavior [
	^ self methodCoder behavior
]

{ #category : #'api - testing' }
GtPharoMethodTestCase >> canExecute [

	| aNode |
	self methodCoder ifNil: [ ^ false ].
	self behavior isTestCase ifFalse: [ ^ false ].
	self behavior isAbstract ifTrue: [ 
		| hasConreteSubclass |
		hasConreteSubclass := false.
		self behavior allSubclassesDo: [ :eachClass | 
			eachClass isAbstract ifFalse: [ hasConreteSubclass := true ] ].
		hasConreteSubclass ifFalse: [ ^ false ] ].

	aNode := self methodCoder rbAST methodNode.
	^ aNode isNotNil and: [ aNode selector isTestSelector ]
]

{ #category : #'accessing - coder' }
GtPharoMethodTestCase >> compiledMethod [
	^ self methodCoder compiledMethod
]

{ #category : #'api - execution' }
GtPharoMethodTestCase >> debug [

	self methodCoder ensureSave ifFalse: [ ^ self ].

	self rawDebug
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
	announcer := Announcer new.
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

{ #category : #'api - testing' }
GtPharoMethodTestCase >> isPassed [

	^ self hasResult and: [ 
		  self result
			  isPassedFor: self behavior
			  selector: self methodSelector ]
]

{ #category : #accessing }
GtPharoMethodTestCase >> isSkipped [

	^ self hasResult and: [ self result skippedCount isZero not ]
]

{ #category : #accessing }
GtPharoMethodTestCase >> methodCoder [
	^ methodCoder
]

{ #category : #accessing }
GtPharoMethodTestCase >> methodCoder: aMethodCoder [ 
	methodCoder := aMethodCoder.
	self subscribeToMethodCoder.
]

{ #category : #'accessing - coder' }
GtPharoMethodTestCase >> methodSelector [
	^ self methodCoder currentSelector
]

{ #category : #'private - notifications' }
GtPharoMethodTestCase >> notifyResultChanged [

	self announce: (GtPharoMethodTestResultChanged new
			 testCase: self;
			 result: self result)
]

{ #category : #'private - hooks' }
GtPharoMethodTestCase >> onMethodCoderChanged [
	self updateState
]

{ #category : #'private - hooks' }
GtPharoMethodTestCase >> onResultChanged [
	self updateState
]

{ #category : #accessing }
GtPharoMethodTestCase >> onSourceCodeChanged: anAnnouncement [
	self updateState.
]

{ #category : #'private - updating' }
GtPharoMethodTestCase >> onStateChanged [
	self announce: (GtPharoMethodTestCaseStateChanged new
		testCase: self;
		state: self state)
]

{ #category : #'api - execution' }
GtPharoMethodTestCase >> play [

	self methodCoder ensureSave ifFalse: [ ^ self ].

	self rawPlay.
]

{ #category : #execution }
GtPharoMethodTestCase >> rawDebug [
	self result: self testCaseInstance debug
]

{ #category : #execution }
GtPharoMethodTestCase >> rawPlay [
	self result: self testCaseInstance run.
]

{ #category : #'accessing - test case' }
GtPharoMethodTestCase >> result [
	<return: #TestResult>
	^ result
]

{ #category : #'accessing - test case' }
GtPharoMethodTestCase >> result: aTestResult [ 
	result := aTestResult.
	self onResultChanged.
	self notifyResultChanged.
]

{ #category : #accessing }
GtPharoMethodTestCase >> state [

	<return: #GtPharoMethodTestCaseState>
	self methodCoder isModified ifTrue: [ 
		^ GtPharoMethodNotExecutedState ].
	^ state
]

{ #category : #'private - updating' }
GtPharoMethodTestCase >> state: aState [ 
	state == aState ifTrue: [ ^ self ].
	state := aState.
	self onStateChanged.
]

{ #category : #'accessing - test case' }
GtPharoMethodTestCase >> stateLabel [
	^ self state label
]

{ #category : #'private - subscriptions' }
GtPharoMethodTestCase >> subscribeToMethodCoder [
	methodCoder weak 
		when: GtCoderAstChanged
		send: #onSourceCodeChanged:
		to: self
]

{ #category : #'accessing - test case' }
GtPharoMethodTestCase >> testCaseInstance [

	^ GtPharoMethodTestSuiteBuilder new
		behavior: self behavior;
		selector: self methodSelector;
		build
]

{ #category : #'private - updating' }
GtPharoMethodTestCase >> updateState [

	self canExecute ifFalse: [ 
		^ self state: GtPharoMethodNotExecutableTestCaseState ].
	self hasResult ifFalse: [
		^ self state: GtPharoMethodNotExecutedState ].
	self state: (GtPharoMethodTestCaseState stateFromTestResult: self result)
]
