Class {
	#name : #GtPharoTestSuite,
	#superclass : #Object,
	#instVars : [
		'testCasesStream',
		'testCasesCache',
		'announcer'
	],
	#category : #'GToolkit-Pharo-TestSuite-Base'
}

{ #category : #'instance creation' }
GtPharoTestSuite class >> forStream: anAsyncStream [
	^ self new stream: anAsyncStream
]

{ #category : #'api - enumerating' }
GtPharoTestSuite >> allErrorTestCases [
	<return: #TAsyncStream>

	^ self allTestCases select: [ :eachTestCase | eachTestCase state = GtPharoMethodTestCaseErrorState ]
]

{ #category : #'api - enumerating' }
GtPharoTestSuite >> allFailureTestCases [
	<return: #TAsyncStream>

	^ self allTestCases select: [ :eachTestCase | eachTestCase state = GtPharoMethodTestCaseFailureState ]
]

{ #category : #'api - enumerating' }
GtPharoTestSuite >> allNotExecutedTestCases [
	<return: #TAsyncStream>

	^ self allTestCases select: [ :eachTestCase | eachTestCase state = GtPharoMethodNotExecutedState ]
]

{ #category : #'api - enumerating' }
GtPharoTestSuite >> allPassedTestCases [
	<return: #TAsyncStream>

	^ self allTestCases select: [ :eachTestCase | eachTestCase state = GtPharoMethodTestCasePassedState ]
]

{ #category : #'api - enumerating' }
GtPharoTestSuite >> allSkippedTestCases [
	<return: #TAsyncStream>

	^ self allTestCases select: [ :eachTestCase | eachTestCase state = GtPharoMethodTestCaseSkippedState ]
]

{ #category : #'api - accessing' }
GtPharoTestSuite >> allTestCaseStates [
	<return: #TAsyncFuture>

	^ (self allTestCases collect: [ :eachTestCase | eachTestCase state ]) to: Set
]

{ #category : #'api - accessing' }
GtPharoTestSuite >> allTestCases [
	"Returns a stream of all executable test cases"
	<return: #TAsyncStream>

	^ testCasesStream asyncSimilarCopy
]

{ #category : #'api - enumerating' }
GtPharoTestSuite >> allTestCasesWithState: aState [
	<return: #TAsyncStream>

	^ self allTestCases select: [ :eachTestCase | eachTestCase state = aState ]
]

{ #category : #'api - announcer' }
GtPharoTestSuite >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'as yet unclassified' }
GtPharoTestSuite >> codersStreamChangedTo: anAsyncMapWithCacheStream [ 
	"a bug?"
]

{ #category : #'private - instance creation' }
GtPharoTestSuite >> createTestCaseForMethod: aCompiledMethod [
	^ GtPharoMethodTestCase forMethod: aCompiledMethod
]

{ #category : #'api - testing' }
GtPharoTestSuite >> hasErrorTestCases [
	<return: #TAsyncFuture>

	^ self allErrorTestCases hasNext
]

{ #category : #'api - testing' }
GtPharoTestSuite >> hasExecutableTestCases [
	<return: #TAsyncFuture>

	^ self allTestCases hasNext
]

{ #category : #'api - testing' }
GtPharoTestSuite >> hasFailureTestCases [
	<return: #TAsyncFuture>

	^ self allFailureTestCases hasNext
]

{ #category : #'api - testing' }
GtPharoTestSuite >> hasNotExecutedTestCases [
	<return: #TAsyncFuture>

	^ self allNotExecutedTestCases hasNext
]

{ #category : #'api - testing' }
GtPharoTestSuite >> hasPassedTestCases [
	<return: #TAsyncFuture>

	^ self allPassedTestCases hasNext
]

{ #category : #'api - testing' }
GtPharoTestSuite >> hasSelectedExecutableTestCases [

	self selectedExecutableTestCasesDo: [ :aCoder :aTestCase | ^ true ].
	^ false
]

{ #category : #'api - testing' }
GtPharoTestSuite >> hasTestCases [
	"Returns a future that resolves to true if there is at least one test case"
	<return: #TAsyncFuture>

	^ self allTestCases isNotEmpty
]

{ #category : #initialization }
GtPharoTestSuite >> initialize [
	super initialize.
	
	testCasesCache := AsyncSharedDictionary new
]

{ #category : #'private - notifying' }
GtPharoTestSuite >> notifyStreamChanged [
	self announcer announce: (GtPharoSuiteStreamChanged new suite: self)
]

{ #category : #'api - counts' }
GtPharoTestSuite >> numberOfAllPassedTestCases [
	<return: #TAsyncFuture>

	^ self allPassedTestCases size
]

{ #category : #'api - counts' }
GtPharoTestSuite >> numberOfAllSkippedTestCases [
	<return: #TAsyncFuture>

	^ self allSkippedTestCases size
]

{ #category : #'api - counts' }
GtPharoTestSuite >> numberOfAllTestCases [
	<return: #TAsyncFuture>
	
	^ self allTestCases size
]

{ #category : #'api - counts' }
GtPharoTestSuite >> numberOfAllTestCasesWithState: aState [
	<return: #TAsyncFuture>

	^ (self allTestCases select: [ :eachTestCase | eachTestCase state = aState ]) size
]

{ #category : #'api - execution' }
GtPharoTestSuite >> playSelected [

	self selectedExecutableTestCasesDo: [ :aCoder :aTestCase | 
		(aCoder isModified not and: [ aTestCase hasNoTestPragma not ]) 
			ifTrue: [ aTestCase play ]
			ifFalse: [ aTestCase beSkipped ] ]
]

{ #category : #'api - execution' }
GtPharoTestSuite >> playSelectedFrom: anElement [
	self playSelected
]

{ #category : #'api - stream' }
GtPharoTestSuite >> stream: anAsyncStream [
	testCasesStream := (((anAsyncStream
		filter: [ :eachMethod | eachMethod isNotNil ])
		map: [ :eachMethod | self createTestCaseForMethod: eachMethod ] cache: testCasesCache)
		filter: [ :eachTestCase | eachTestCase canExecute ])
		cached.
	self notifyStreamChanged.
]

{ #category : #'api - accessing' }
GtPharoTestSuite >> testCaseForMethod: aCompiledMethod [
	^ testCasesCache
		at: aCompiledMethod
		ifAbsentPut: [ self createTestCaseForMethod: aCompiledMethod ]
]

{ #category : #'api - announcer' }
GtPharoTestSuite >> unsubscribe: aSubscriber [
	self announcer unsubscribe: aSubscriber
]

{ #category : #'api - announcer' }
GtPharoTestSuite >> when: anAnnouncementClass send: aSelector to: aReceiver [
	self announcer weak
		when: anAnnouncementClass
		send: aSelector
		to: aReceiver
]
