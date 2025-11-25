Class {
	#name : #GtPharoExampleSuiteViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoExampleSuite + TGtPharoSuiteViewModel',
	#classTraits : 'TGtWithPharoExampleSuite classTrait + TGtPharoSuiteViewModel classTrait',
	#instVars : [
		'announcer',
		'executor',
		'executionState'
	],
	#category : 'GToolkit-Pharo-TestSuite-UI-! View Models'
}

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> allStates [

	^ GtExampleState default allStates
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> allSuiteCases [
	<return: #TAsyncStream>

	^ self hasPharoExampleSuite
		ifTrue: [ pharoExampleSuite allExamples ]
		ifFalse: [ AsyncEmptyStream new ]
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> allSuiteCasesState [
	^ GtFilterExampleAllState uniqueInstance
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> allSuiteStates [
	"Return a set of states of all suite cases"
	<return: #TAsyncStream>

	^ self pharoExampleSuite allExampleStates
]

{ #category : #'api - announcer' }
GtPharoExampleSuiteViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
]

{ #category : #'api - announcer' }
GtPharoExampleSuiteViewModel >> announcer [

	^ announcer
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> beLocalFrom: aSource [

	self executor: GtPharoLocalExampleSuiteExecutor new
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> beRemoteFrom: aSource [

	self executor: GtPharoRemoteExamplesExecutor new
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> executionDetail [

	^ self executionState value
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> executionError: anError [
	self executionState: #exception -> anError
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> executionState [

	^ executionState ifNil: [ executionState := #unknown -> nil ]
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> executionState: aStateAssociation [

	self executionState = aStateAssociation ifTrue: [ ^ self ].
	executionState := aStateAssociation
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> executor [

	<return: #TGtPharoSuiteExecutor>
	^ executor
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> executor: anExecutor [
	executor := anExecutor
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> hasExecutionError [

	^ self executionState key = #exception
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> hasPendingExecution [

	^ self executionState key = #pending
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> hasSuiteCases [
	"Return a future which resolves to true if there is at least one suite case, false otherwise"
	<return: #TAsyncFuture>
	
	^ self pharoExampleSuite hasExamples
]

{ #category : #initialization }
GtPharoExampleSuiteViewModel >> initialize [

	super initialize.

	announcer := Announcer new.
	executor := GtPharoLocalExampleSuiteExecutor new.
	selectedState := self allSuiteCasesState
]

{ #category : #'private - accessing' }
GtPharoExampleSuiteViewModel >> methodsCoderModelDo: aBlock [
]

{ #category : #'private - announcement handling' }
GtPharoExampleSuiteViewModel >> onSuiteStreamChanged: anAnnouncement [
	self announce: anAnnouncement
]

{ #category : #'api - pharo example suite' }
GtPharoExampleSuiteViewModel >> subscribeToPharoExampleSuite [
	self pharoExampleSuite
		when: GtPharoSuiteStreamChanged
		send: #onSuiteStreamChanged:
		to: self
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> suiteCaseStateOf: aSuiteCaseObject [
	^ pharoExampleSuite stateOf: aSuiteCaseObject
]

{ #category : #'private - accessing' }
GtPharoExampleSuiteViewModel >> totalStringForState: aState [

	self methodsCoderModelDo: [ :aCoder | 
		| aTotal |
		aTotal := aState numberOfExamplesFor: aCoder exampler.
		^ aTotal asString , (' example' asPluralBasedOn: aTotal) ].
	^ '?'
]

{ #category : #'api - announcer' }
GtPharoExampleSuiteViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - pharo example suite' }
GtPharoExampleSuiteViewModel >> unsubscribeFromPharoExampleSuite [
	self pharoExampleSuite unsubscribe: self
]

{ #category : #'api - announcer' }
GtPharoExampleSuiteViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPharoExampleSuiteViewModel >> when: anAnnouncementClass do: aBlock for: aSubscriber [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoForTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock for: aSubscriber
]

{ #category : #'api - announcer' }
GtPharoExampleSuiteViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
