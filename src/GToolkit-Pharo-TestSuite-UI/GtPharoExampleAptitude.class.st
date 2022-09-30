"
I display a summary of example states, e.g., successfully executed.
#Example
For the following methods: {{gtExample:GtPharoExampleAptitudeExamples >> #methodsCoders | codeExpanded=false | previewExpanded=true | previewShow=#gtLiveFor:}}
I display the following icon presenting the all actual example states (execution results): {{gtExample:GtPharoExampleAptitudeExamples >> #buttonWithAptitudeAndMethodCoders_Executed | codeExpanded=false | previewExpanded=true }}
"
Class {
	#name : #GtPharoExampleAptitude,
	#superclass : #GtPharoFourStateAptitude,
	#category : #'GToolkit-Pharo-TestSuite-UI-Aptitudes'
}

{ #category : #'private - accessing' }
GtPharoExampleAptitude >> examplerDo: aBlock [

	"self coderDo: [ :aCoder | aBlock cull: aCoder exampler ]"
]

{ #category : #'private - announcement handling' }
GtPharoExampleAptitude >> onExampleExecuted: aGtCoderExampleExecuted [

	self updater requestUpdate
]

{ #category : #'private - subscriptions' }
GtPharoExampleAptitude >> subscribeToCoder [

	super subscribeToCoder.
	"self coderDo: [ :aCoder | 
		aCoder coders do: [ :aMethodCoder | 
			self subscribeToCodersCoder: aMethodCoder ] ]"
]

{ #category : #'private - subscriptions' }
GtPharoExampleAptitude >> subscribeToCodersCoder: aMethodCoder [

	super subscribeToCodersCoder: aMethodCoder.
	aMethodCoder weak
		when: GtCoderExampleExecuted
		send: #onExampleExecuted:
		to: self
]

{ #category : #'private - subscriptions' }
GtPharoExampleAptitude >> unsubscribeFromCoder [

	super unsubscribeFromCoder.
	self coderDo: [ :aCoder | 
		aCoder coders do: [ :aMethodCoder | 
			self unsubscribeFromCodersCoder: aMethodCoder ] ]
]

{ #category : #'private - updating' }
GtPharoExampleAptitude >> updateElement [
	super updateElement.
	self widgetDo: [ :aWidget | 
		self examplerDo: [ :anExampler | 
			| aState |
			aState := anExampler hasSelectedExecutableExamples.
			aWidget dispatchEvent: (BrEnablementWish enabled: aState).
			anExampler hasExamples
				ifFalse: [ aWidget visibility: BlVisibility gone ]
				ifTrue: [ 
					aWidget visibility: BlVisibility visible.
					self updateFourIconElement ] ] ]
]

{ #category : #'private - updating' }
GtPharoExampleAptitude >> updateFourIconElement [

	self examplerDo: [ :anExampler | 
		| allStates |
		allStates := anExampler allExampleStates.

		allStates size = 1 ifTrue: [ 
			self fourIconElement visibility: BlVisibility gone.
			self oneIconElement visibility: BlVisibility visible.
			self oneIconElement background: allStates anyOne color.
			^ self ].

		self fourIconElement visibility: BlVisibility visible.
		self oneIconElement visibility: BlVisibility gone.

		self
			updateIconElement: self neutralIconElement
			status: anExampler hasNotExecutedExamples.
		self
			updateIconElement: self errorIconElement
			status: anExampler hasErrorExamples.
		self
			updateIconElement: self failureIconElement
			status: anExampler hasFailureExamples.
		self
			updateIconElement: self passedIconElement
			status: anExampler hasSuccessExamples ]
]

{ #category : #'private - updating' }
GtPharoExampleAptitude >> updateIconElement: anElement status: aBoolean [

	aBoolean
		ifTrue: [ anElement visibility: BlVisibility visible ]
		ifFalse: [ anElement visibility: BlVisibility hidden ]
]
