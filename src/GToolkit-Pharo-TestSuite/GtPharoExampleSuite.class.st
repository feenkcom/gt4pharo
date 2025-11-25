"
I am an example executor.
I am used by {{gtClass:GtCodersModel}}, see: {{gtMethod:Behavior>>#gtCoderStreamingMethodsFor:context:}} for a usage.


"
Class {
	#name : #GtPharoExampleSuite,
	#superclass : #Object,
	#instVars : [
		'examplesWithResultStream',
		'examplesWithResultCache',
		'announcer',
		'mutex'
	],
	#category : 'GToolkit-Pharo-TestSuite-Base'
}

{ #category : #'api - instance creation' }
GtPharoExampleSuite class >> forStream: anAsyncStream [
	^ self new stream: anAsyncStream
]

{ #category : #'api - accessing' }
GtPharoExampleSuite >> allExamples [
	<return: #TAsyncStream>

	^ examplesWithResultStream asyncSimilarCopy
]

{ #category : #'api - accessing' }
GtPharoExampleSuite >> allExampleStates [
	<return: #TAsyncStream>

	^ (self allExamples collect: [ :eachExampleWithResult | self stateOf: eachExampleWithResult ]) withoutDuplicates
]

{ #category : #'api - enumeration' }
GtPharoExampleSuite >> allExecutableExampleCodersDo: aBlock [
	self allExampleCodersDo: [ :aCoder :anExample | 
		aCoder canExecuteExample ifTrue: [ 
			aBlock cull: aCoder cull: anExample ] ]
]

{ #category : #'api - enumeration' }
GtPharoExampleSuite >> allExecutableExampleCodersWithResultsDo: aBlock [
	self allExecutableExampleCodersDo: [ :aCoder :anExample | 
		aCoder exampleResult ifNotNil: [ :aResult |
			aBlock cull: aCoder cull: anExample cull: aResult ] ]
]

{ #category : #'api - announcer' }
GtPharoExampleSuite >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'private - instance creation' }
GtPharoExampleSuite >> createExampleCaseForMethod: aCompiledMethod [
	^ aCompiledMethod gtExample
]

{ #category : #'api - accessing' }
GtPharoExampleSuite >> exampleWithResultForMethod: aCompiledMethod [
	<return: #GtExampleWithResult or: nil>
	^ examplesWithResultCache
		at: {aCompiledMethod methodClass.
				aCompiledMethod}
		ifAbsent: [ aCompiledMethod gtExampleWithResult  ]
]

{ #category : #'api - testing' }
GtPharoExampleSuite >> hasErrorExamples [
	<return: #Boolean>
	self allExecutableExampleCodersWithResultsDo: [ :eachCoder | 
		eachCoder exampleResult isError ifTrue: [ 
			^ true ] ].
	^ false
]

{ #category : #'api - testing' }
GtPharoExampleSuite >> hasExamples [
	"Returns a future that resolves to true if there is at least one example"
	<return: #TAsyncFuture>

	^ self allExamples isNotEmpty
]

{ #category : #'api - testing' }
GtPharoExampleSuite >> hasFailureExamples [
	<return: #Boolean>
	self allExecutableExampleCodersWithResultsDo: [ :eachCoder | 
		eachCoder exampleResult isFailure ifTrue: [ 
			^ true ] ].
	^ false
]

{ #category : #'api - testing' }
GtPharoExampleSuite >> hasNotExecutedExamples [
	<return: #Boolean>
	self allExecutableExampleCodersDo: [ :eachCoder | 
		eachCoder exampleResult ifNil: [ 
			^ true ] ].
	^ false
]

{ #category : #'api - testing' }
GtPharoExampleSuite >> hasSelectedExecutableExamples [
	self selectedExecutableExampleCodersDo: [ ^ true ].
	^ false
]

{ #category : #'api - testing' }
GtPharoExampleSuite >> hasSuccessExamples [
	<return: #Boolean>
	self allExecutableExampleCodersWithResultsDo: [ :eachCoder | 
		eachCoder exampleResult isSuccess ifTrue: [ 
			^ true ] ].
	^ false
]

{ #category : #accessing }
GtPharoExampleSuite >> initialize [
	super initialize.

	examplesWithResultCache := AsyncSharedDictionary new.
	examplesWithResultStream := AsyncEmptyStream new.
	mutex := Mutex new.
]

{ #category : #'private - notifying' }
GtPharoExampleSuite >> notifyStreamChanged [
	self announcer announce: (GtPharoSuiteStreamChanged new suite: self)
]

{ #category : #'api - accessing' }
GtPharoExampleSuite >> numberOfAllExamples [
	<return: #Integer>
	| aTotal |
	aTotal := 0.
	self allExecutableExampleCodersDo: [ :eachCoder | 
		aTotal := aTotal + 1 ].
	^ aTotal
]

{ #category : #'api - accessing' }
GtPharoExampleSuite >> numberOfErrorExamples [
	<return: #Integer>
	| aTotal |
	aTotal := 0.
	self allExecutableExampleCodersWithResultsDo: [ :eachCoder | 
		eachCoder exampleResult isError ifTrue: [ 
			aTotal := aTotal + 1 ] ].
	^ aTotal
]

{ #category : #'api - accessing' }
GtPharoExampleSuite >> numberOfFailureExamples [
	<return: #Integer>
	| aTotal |
	aTotal := 0.
	self allExecutableExampleCodersWithResultsDo: [ :eachCoder | 
		eachCoder exampleResult isFailure ifTrue: [ 
			aTotal := aTotal + 1 ] ].
	^ aTotal
]

{ #category : #'api - accessing' }
GtPharoExampleSuite >> numberOfNotExecutedExamples [
	<return: #Integer>
	| aTotal |
	aTotal := 0.
	self allExecutableExampleCodersDo: [ :eachCoder | 
		eachCoder exampleResult ifNil: [ 
			aTotal := aTotal + 1 ] ].
	^ aTotal
]

{ #category : #'api - accessing' }
GtPharoExampleSuite >> numberOfSuccessExamples [
	<return: #Integer>
	| aTotal |
	aTotal := 0.
	self allExecutableExampleCodersWithResultsDo: [ :eachCoder | 
		eachCoder exampleResult isSuccess ifTrue: [ 
			aTotal := aTotal + 1 ] ].
	^ aTotal
]

{ #category : #'api - enumeration' }
GtPharoExampleSuite >> selectedExecutableExampleCodersDo: aBlock [
	self selectedExampleCodersDo: [ :aCoder :anExample | 
		aCoder canExecuteExample ifTrue: [ 
			aBlock cull: aCoder cull: anExample ] ]
]

{ #category : #'api - enumeration' }
GtPharoExampleSuite >> selectedExecutableExampleCodersWithResultsDo: aBlock [
	self selectedExecutableExampleCodersDo: [ :aCoder :anExample | 
		aCoder exampleResult ifNotNil: [ :aResult |
			aBlock cull: aCoder cull: anExample cull: aResult ] ]
]

{ #category : #'api - accessing' }
GtPharoExampleSuite >> stateOf: aGtExampleWithResult [
	^ GtExampleState default stateFromExample: aGtExampleWithResult
]

{ #category : #'api - stream' }
GtPharoExampleSuite >> stream: anAsyncStream [
	mutex critical: [ 
		examplesWithResultCache := AsyncSharedDictionary new.
		examplesWithResultStream := ((((((anAsyncStream
				filter: [ :eachItem | eachItem notNil ])
				map: [ :eachItem | eachItem gtExample ])
				filter: [ :eachExample | eachExample notNil ])
				map: [ :eachExample | 
					| aMethod |
					eachExample methodDo: [ :theMethod | aMethod := theMethod ].
					aMethod ifNotNil: [ aMethod -> eachExample asExampleWithResult ] ])
				filter: [ :anAssoc | anAssoc notNil ])
				map: [ :anAssoc | anAssoc value ]
				key: [ :anAssoc | { anAssoc value providerClass. anAssoc key } ]
				cache: examplesWithResultCache) 
				cached ].
	self notifyStreamChanged
]

{ #category : #'api - announcer' }
GtPharoExampleSuite >> unsubscribe: aSubscriber [
	self announcer unsubscribe: aSubscriber
]

{ #category : #'api - announcer' }
GtPharoExampleSuite >> when: anAnnouncementClass send: aSelector to: aReceiver [
	self announcer weak
		when: anAnnouncementClass
		send: aSelector
		to: aReceiver
]
