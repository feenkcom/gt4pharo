Class {
	#name : #GtPharoTestSuiteViewModel,
	#superclass : #Object,
	#traits : 'TGtPharoSuiteViewModel + TGtPharoWithSubscribedMethodsCoderModel + TGtAnnouncer',
	#classTraits : 'TGtPharoSuiteViewModel classTrait + TGtPharoWithSubscribedMethodsCoderModel classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'coder',
		'announcer',
		'executor'
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

{ #category : #accessing }
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
GtPharoTestSuiteViewModel >> executor [

	<return: #TGtPharoSuiteExecutor>
	^ executor
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> executor: anExecutor [

	executor := anExecutor.
	self notifyChanged
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

{ #category : #'private - notifying' }
GtPharoTestSuiteViewModel >> notifyChanged [

	self announce: GtPharoSuiteViewModelChanged new
]

{ #category : #'api - methods coder model' }
GtPharoTestSuiteViewModel >> onCodersCoderAdded: aGtCodersCoderAdded [

	self notifyChanged
]

{ #category : #'api - methods coder model' }
GtPharoTestSuiteViewModel >> onCodersCoderRemoved: aGtCodersCoderRemoved [

	self notifyChanged
]

{ #category : #'api - methods coder model' }
GtPharoTestSuiteViewModel >> onCodersCoderSourceCodeChanged: aGtCoderSourceCodeChanged [

	self notifyChanged
]

{ #category : #'api - methods coder model' }
GtPharoTestSuiteViewModel >> onCodersCoderTestCaseAnnouncement: aGtPharoMethodTestCaseAnnouncement [

	self notifyChanged
]

{ #category : #'api - methods coder model' }
GtPharoTestSuiteViewModel >> onCodersCodersChanged: aGtCodersCodersChanged [

	self notifyChanged
]

{ #category : #'api - methods coder model' }
GtPharoTestSuiteViewModel >> onMethodsCoderModelChanged [

	self notifyChanged
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> playFrom: anElement [

	self methodsCoderModelDo: [ :aCoder | 
		self executor playSelectedInMethodsCoder: aCoder ]
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
