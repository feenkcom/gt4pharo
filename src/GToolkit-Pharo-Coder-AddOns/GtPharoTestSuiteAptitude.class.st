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
	self widgetDo: [ :aWidget | 
		self testSuiteDo: [ :aTestSuite | 
			| aState |
			aState := aTestSuite hasSelectedExecutableTestCases.
			aWidget dispatchEvent: (BrEnablementWish enabled: aState).
			aTestSuite hasExecutableTestCases
				ifFalse: [ aWidget visibility: BlVisibility gone ]
				ifTrue: [ 
					aWidget visibility: BlVisibility visible.
					self updateFourIconElement ] ] ]
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
