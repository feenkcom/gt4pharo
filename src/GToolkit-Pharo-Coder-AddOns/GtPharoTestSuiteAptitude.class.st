"
I display a summary of test case states, e.g., successfully executed.
#Example
For the following methods: {{gtExample:GtPharoTestSuiteAptitudeExamples >> #methodsCoders_Executed | codeExpanded=false | previewExpanded=true | previewShow=#gtLiveFor:}}
I display the following icon presenting the all actual test case states (execution results): {{gtExample:GtPharoTestSuiteAptitudeExamples >> #buttonWithAptitudeAndMethodCoders_Executed | codeExpanded=false | previewExpanded=true }}
"
Class {
	#name : #GtPharoTestSuiteAptitude,
	#superclass : #GtPharoFourStateAptitude,
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #'private - announcement handling' }
GtPharoTestSuiteAptitude >> onTestCaseStateChanged: anAnnouncement [
	self updater requestUpdate.
]

{ #category : #'private - announcement handling' }
GtPharoTestSuiteAptitude >> onTestResultChanged: anAnnouncement [
	self updater requestUpdate.
]

{ #category : #'private - subscriptions' }
GtPharoTestSuiteAptitude >> subscribeToCoder [

	super subscribeToCoder.
	self coderDo: [ :aCoder | 
		aCoder coders do: [ :aMethodCoder | 
			self subscribeToCodersCoder: aMethodCoder ] ]
]

{ #category : #'private - subscriptions' }
GtPharoTestSuiteAptitude >> subscribeToCodersCoder: aMethodCoder [

	super subscribeToCodersCoder: aMethodCoder.
	aMethodCoder testCase weak
		when: GtPharoMethodTestCaseStateChanged
		send: #onTestCaseStateChanged:
		to: self;
		when: GtPharoMethodTestResultChanged
		send: #onTestResultChanged:
		to: self
]

{ #category : #accessing }
GtPharoTestSuiteAptitude >> testSuiteDo: aBlock [

	self coderDo: [ :aCoder | aBlock cull: aCoder testSuite ]
]

{ #category : #'private - subscriptions' }
GtPharoTestSuiteAptitude >> unsubscribeFromCoder [

	super unsubscribeFromCoder.
	self coderDo: [ :aCoder | 
		aCoder coders do: [ :aMethodCoder | 
			self unsubscribeFromCodersCoder: aMethodCoder ] ]
]

{ #category : #'private - subscriptions' }
GtPharoTestSuiteAptitude >> unsubscribeFromCodersCoder: aMethodCoder [

	super unsubscribeFromCodersCoder: aMethodCoder.
	aMethodCoder testCase unsubscribe: self
]

{ #category : #'private - updating' }
GtPharoTestSuiteAptitude >> updateElement [

	super updateElement.
	self testSuiteDo: [ :aTestSuite | 
		| hasTests |
		hasTests := aTestSuite hasExecutableTestCases.
		self widgetDo: [ :aWidget | 
			hasTests
				ifFalse: [ aWidget visibility: BlVisibility gone ]
				ifTrue: [ 
					| hasSelectedTests |
					aWidget visibility: BlVisibility visible.
					hasSelectedTests := aTestSuite hasSelectedExecutableTestCases.
					aWidget dispatchEvent:
						(BrEnablementWish enabled: hasSelectedTests) ] ].

		hasTests ifTrue: [ self updateFourIconElement ] ]
]

{ #category : #'private - updating' }
GtPharoTestSuiteAptitude >> updateFourIconElement [

	self testSuiteDo: [ :aTestSuite | 
		| allStates |
		allStates := aTestSuite allTestCaseStates.

		allStates size = 1 ifTrue: [ 
			self fourIconElement visibility: BlVisibility gone.
			self oneIconElement visibility: BlVisibility visible.
			self oneIconElement background: allStates anyOne color.
			^ self ].

		self fourIconElement visibility: BlVisibility visible.
		self oneIconElement visibility: BlVisibility gone.

		self
			updateIconElement: self neutralIconElement
			status: aTestSuite hasNotExecutedTestCases.
		self
			updateIconElement: self errorIconElement
			status: aTestSuite hasErrorTestCases.
		self
			updateIconElement: self failureIconElement
			status: aTestSuite hasFailureTestCases.
		self
			updateIconElement: self passedIconElement
			status: aTestSuite hasPassedTestCases ]
]

{ #category : #'private - updating' }
GtPharoTestSuiteAptitude >> updateIconElement: anElement status: aBoolean [

	aBoolean
		ifTrue: [ anElement visibility: BlVisibility visible ]
		ifFalse: [ anElement visibility: BlVisibility hidden ]
]
