Class {
	#name : #GtPharoTestSuiteViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoTestSuite + TGtPharoSuiteViewModel',
	#classTraits : 'TGtWithPharoTestSuite classTrait + TGtPharoSuiteViewModel classTrait',
	#instVars : [
		'announcer',
		'executor',
		'executionState'
	],
	#category : 'GToolkit-Pharo-TestSuite-UI-! View Models'
}

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> allStates [

	^ { 
		  GtPharoMethodTestCaseAllState.
		  GtPharoMethodTestCasePassedState.
		  GtPharoMethodTestCaseSkippedState.
		  GtPharoMethodTestCaseFailureState.
		  GtPharoMethodTestCaseErrorState.
		  GtPharoMethodNotExecutedState }
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> allSuiteCases [
	<return: #TAsyncStream>

	^ self hasPharoTestSuite
		ifTrue: [ pharoTestSuite allTestCases ]
		ifFalse: [ AsyncEmptyStream new ]
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> allSuiteCasesState [
	^ GtPharoMethodTestCaseAllState
]

{ #category : #'api - announcer' }
GtPharoTestSuiteViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
]

{ #category : #'api - announcer' }
GtPharoTestSuiteViewModel >> announcer [

	^ announcer
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> beLocalFrom: aSource [

	self executor: GtPharoLocalTestSuiteExecutor new
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> beRemoteFrom: aSource [

	self executor: GtPharoRemoteTestSuiteExecutor new
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> executionDetail [

	^ self executionState value
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> executionError: anError [
	self executionState: #exception -> anError
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> executionState [

	^ executionState ifNil: [ executionState := #unknown -> nil ]
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> executionState: aStateAssociation [
	self executionState = aStateAssociation
		ifTrue: [ ^ self ].

	executionState := aStateAssociation
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> executor [
	<return: #TGtPharoSuiteExecutor>

	^ executor
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> executor: anExecutor [
	executor := anExecutor
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> hasExecutionError [

	^ self executionState key = #exception
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> hasPendingExecution [

	^ self executionState key = #pending
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> hasSuiteCases [
	"Return a future which resolves to true if there is at least one suite case, false otherwise"
	<return: #TAsyncFuture>
	
	^ self pharoTestSuite hasTestCases
]

{ #category : #initialization }
GtPharoTestSuiteViewModel >> initialize [

	super initialize.

	announcer := Announcer new.
	executor := GtPharoLocalTestSuiteExecutor new.
	selectedState := self allSuiteCasesState
]

{ #category : #'private - announcement handling' }
GtPharoTestSuiteViewModel >> onSuiteStreamChanged: anAnnouncement [
	self announce: anAnnouncement
]

{ #category : #'api - pharo test suite' }
GtPharoTestSuiteViewModel >> subscribeToPharoTestSuite [
	self pharoTestSuite
		when: GtPharoSuiteStreamChanged
		send: #onSuiteStreamChanged:
		to: self
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> suiteCaseStateOf: aSuiteCaseObject [
	^ aSuiteCaseObject state
]

{ #category : #'api - announcer' }
GtPharoTestSuiteViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - pharo test suite' }
GtPharoTestSuiteViewModel >> unsubscribeFromPharoTestSuite [
	self pharoTestSuite unsubscribe: self
]

{ #category : #'api - announcer' }
GtPharoTestSuiteViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPharoTestSuiteViewModel >> when: anAnnouncementClass do: aBlock for: aSubscriber [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoForTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock for: aSubscriber
]

{ #category : #'api - announcer' }
GtPharoTestSuiteViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
