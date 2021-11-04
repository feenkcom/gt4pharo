Class {
	#name : #GtPharoTestSuiteViewModel,
	#superclass : #Object,
	#traits : 'TGtPharoSuiteViewModel + TGtPharoWithSubscribedMethodsCoderModel + TGtAnnouncer',
	#classTraits : 'TGtPharoSuiteViewModel classTrait + TGtPharoWithSubscribedMethodsCoderModel classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'coder',
		'announcer',
		'executor',
		'executionState'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> allStates [

	^ { 
		  GtPharoMethodAllState.
		  GtPharoMethodTestCasePassedState.
		  GtPharoMethodTestCaseSkippedState.
		  GtPharoMethodTestCaseFailureState.
		  GtPharoMethodTestCaseErrorState.
		  GtPharoMethodNotExecutedState }
]

{ #category : #announcer }
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
GtPharoTestSuiteViewModel >> executionState [

	^ executionState ifNil: [ executionState := #unknown -> nil ]
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> executionState: aStateAssociation [

	self executionState = aStateAssociation ifTrue: [ ^ self ].

	executionState := aStateAssociation.

	self notifyCodersCoderChanged
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> executor [

	<return: #TGtPharoSuiteExecutor>
	^ executor
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> executor: anExecutor [

	executor := anExecutor.
	self notifyCodersCoderChanged
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
GtPharoTestSuiteViewModel >> hasSelectedExecutableSuiteItems [

	self methodsCoderModelDo: [ :aCoder | 
		^ aCoder testSuite hasSelectedExecutableTestCases ].

	^ false
]

{ #category : #initialization }
GtPharoTestSuiteViewModel >> initialize [

	super initialize.

	announcer := Announcer new.
	executor := GtPharoLocalTestSuiteExecutor new
]

{ #category : #'private - accessing' }
GtPharoTestSuiteViewModel >> methodsCoderModelDo: aBlock [

	methodsCoderModel ifNotNil: aBlock
]

{ #category : #deprecated }
GtPharoTestSuiteViewModel >> notifyChanged [

	self notifyCodersCoderChanged
]

{ #category : #'api - methods coder model' }
GtPharoTestSuiteViewModel >> notifyCodersCoderChanged [

	"Notify one or more method coders changed"
	
	self announce: GtPharoSuiteViewModelChanged new
]

{ #category : #'api - methods coder model' }
GtPharoTestSuiteViewModel >> onCodersCoderTestCaseAnnouncement: aGtPharoMethodTestCaseAnnouncement [

	self notifyCodersCoderChanged
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> playFrom: anElement [

	self methodsCoderModelDo: [ :aCoder | 
		| aFuture |
		self executionState: #pending -> nil.
		aFuture := [ self executor playSelectedInMethodsCoder: aCoder ]
			           asAsyncFuture.
		aFuture await
			onSuccessDo: [ :aResult | self executionState: #success -> aResult ];
			onFailureDo: [ :anException | 
				self executionState: #exception -> anException ] ]
]

{ #category : #'api - methods coder model' }
GtPharoTestSuiteViewModel >> subscribeExtraToCodersCoder: aMethodCoder [

	aMethodCoder testCase weak
		when: GtPharoMethodTestCaseAnnouncement
		send: #onCodersCoderTestCaseAnnouncement:
		to: self
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> totalStringForState: aState [

	| aTotal |
	self methodsCoderModelDo: [ :aCoder | 
		aTotal := aState numberOfMethodsIn: aCoder.
		^ aTotal asString , (' test' asPluralBasedOn: aTotal) ].
	^ '?'
]

{ #category : #'api - methods coder model' }
GtPharoTestSuiteViewModel >> unsubscribeExtraToCodersCoder: aMethodCoder [

	aMethodCoder testCase unsubscribe: self
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> updateCoderFilterWith: aState source: aSource [

	self methodsCoderModelDo: [ :aMethodsCoder | 
		aMethodsCoder
			setFilters: { (GtPharoTestCaseStateFilter new
					 resultState: aState;
					 coder: aMethodsCoder) }
			source: aSource ]
]
