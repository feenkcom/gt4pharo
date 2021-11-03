Class {
	#name : #GtPharoExampleSuiteViewModel,
	#superclass : #Object,
	#traits : 'TGtPharoSuiteViewModel + TGtPharoWithSubscribedMethodsCoderModel + TGtAnnouncer',
	#classTraits : 'TGtPharoSuiteViewModel classTrait + TGtPharoWithSubscribedMethodsCoderModel classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'executor',
		'executionState'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Examples'
}

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> allStates [

	^ GtFilterExampleState default allStates
]

{ #category : #announcer }
GtPharoExampleSuiteViewModel >> announcer [

	^ announcer
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> beLocalFrom: aSource [

	self executor: GtPharoLocalExampleSuiteExecutor new
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> beRemoteFrom: aSource [

	self executor: GtPharoRemoteExampleSuiteExecutor new
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> executionDetail [

	^ self executionState value
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> executionState [

	^ executionState ifNil: [ executionState := #unknown -> nil ]
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> executionState: aStateAssociation [

	self executionState = aStateAssociation ifTrue: [ ^ self ].

	executionState := aStateAssociation.

	self notifyCodersCoderChanged
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> executor [

	<return: #TGtPharoSuiteExecutor>
	^ executor
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> executor: anExecutor [

	executor := anExecutor.
	self notifyCodersCoderChanged
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
GtPharoExampleSuiteViewModel >> hasSelectedExecutableSuiteItems [

	self methodsCoderModelDo: [ :aCoder | 
		^ aCoder exampler hasSelectedExecutableExamples ].

	^ false
]

{ #category : #initialization }
GtPharoExampleSuiteViewModel >> initialize [

	super initialize.

	announcer := Announcer new.
	executor := GtPharoLocalExampleSuiteExecutor new
]

{ #category : #'private - accessing' }
GtPharoExampleSuiteViewModel >> methodsCoderModelDo: aBlock [

	methodsCoderModel ifNotNil: aBlock
]

{ #category : #'api - methods coder model' }
GtPharoExampleSuiteViewModel >> notifyCodersCoderChanged [

	"Notify one or more method coders changed"
	
	self announce: GtPharoSuiteViewModelChanged new
]

{ #category : #'api - methods coder model' }
GtPharoExampleSuiteViewModel >> onCodersCoderExampleExecuted: aGtCoderExampleExecuted [

	self notifyCodersCoderChanged
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> playFrom: anElement [

	self methodsCoderModelDo: [ :aCoder | 
		| aFuture |
		self executionState: #pending -> nil.
		aFuture := [ self executor playSelectedInMethodsCoder: aCoder ]
			           asAsyncFuture.
		aFuture await
			onSuccessDo: [ :aResult | self executionState: #success -> aResult ];
			onFailureDo: [ :anException | 
				self executionState: #failure -> anException ] ]
]

{ #category : #'api - methods coder model' }
GtPharoExampleSuiteViewModel >> subscribeExtraToCodersCoder: aMethodCoder [

	aMethodCoder weak
		when: GtCoderExampleExecuted
		send: #onCodersCoderExampleExecuted:
		to: self
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> totalStringForState: aState [

	self methodsCoderModelDo: [ :aCoder | 
		| aTotal |
		aTotal := aState numberOfExamplesFor: aCoder exampler.
		^ aTotal asString , (' example' asPluralBasedOn: aTotal) ].
	^ '?'
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> updateCoderFilterWith: aState source: aSource [

	self methodsCoderModelDo: [ :aMethodsCoder | 
		aMethodsCoder
			setFilters: { (GtSearchExamplesFilter new
					 resultState: aState;
					 coder: aMethodsCoder) }
			source: aSource ]
]
