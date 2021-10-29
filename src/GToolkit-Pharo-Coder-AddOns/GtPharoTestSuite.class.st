Class {
	#name : #GtPharoTestSuite,
	#superclass : #Object,
	#instVars : [
		'coder'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #'api - enumerating' }
GtPharoTestSuite >> allCodersDo: aBlock [

	self coder allCoders do: aBlock
]

{ #category : #'api - enumerating' }
GtPharoTestSuite >> allErrorTestCasesDo: aBlock [

	self allExecutableTestCasesDo: [ :aCoder :aTestCase | 
		aTestCase state = GtPharoMethodTestCaseErrorState ifTrue: [ 
			aBlock cull: aCoder cull: aTestCase ] ]
]

{ #category : #'api - enumerating' }
GtPharoTestSuite >> allExecutableTestCasesDo: aBlock [

	self allCodersDo: [ :eachCoder | 
		eachCoder testCase canExecute ifTrue: [ 
			aBlock cull: eachCoder cull: eachCoder testCase ] ]
]

{ #category : #'api - enumerating' }
GtPharoTestSuite >> allFailureTestCasesDo: aBlock [

	self allExecutableTestCasesDo: [ :aCoder :aTestCase | 
		aTestCase state = GtPharoMethodTestCaseFailureState ifTrue: [ 
			aBlock cull: aCoder cull: aTestCase ] ] 
]

{ #category : #'api - enumerating' }
GtPharoTestSuite >> allNotExecutedTestCasesDo: aBlock [

	self allExecutableTestCasesDo: [ :aCoder :aTestCase | 
		aTestCase state = GtPharoMethodNotExecutedState ifTrue: [ 
			aBlock cull: aCoder cull: aTestCase ] ]
]

{ #category : #'api - enumerating' }
GtPharoTestSuite >> allPassedTestCasesDo: aBlock [

	self allExecutableTestCasesDo: [ :aCoder :aTestCase | 
		aTestCase state = GtPharoMethodTestCasePassedState ifTrue: [ 
			aBlock cull: aCoder cull: aTestCase ] ]  
]

{ #category : #'api - enumerating' }
GtPharoTestSuite >> allSkippedTestCasesDo: aBlock [

	self allExecutableTestCasesDo: [ :aCoder :aTestCase | 
		aTestCase state = GtPharoMethodTestCaseSkippedState ifTrue: [ 
			aBlock cull: aCoder cull: aTestCase ] ]  
]

{ #category : #'api - accessing' }
GtPharoTestSuite >> allTestCaseStates [

	| aSet |
	aSet := Set new.

	self allExecutableTestCasesDo: [ :aCoder :aTestCase | 
		aSet add: aTestCase state ].

	^ aSet
]

{ #category : #accessing }
GtPharoTestSuite >> coder [

	^ coder
]

{ #category : #accessing }
GtPharoTestSuite >> coder: aCoder [

	coder := aCoder
]

{ #category : #'api - testing' }
GtPharoTestSuite >> hasErrorTestCases [

	self allErrorTestCasesDo: [ ^ true ].
	^ false
]

{ #category : #'api - testing' }
GtPharoTestSuite >> hasExecutableTestCases [

	self allExecutableTestCasesDo: [ :aCoder :aTestCase | ^ true ].
	^ false
]

{ #category : #'api - testing' }
GtPharoTestSuite >> hasFailureTestCases [

	self allFailureTestCasesDo: [ ^ true ].
	^ false
]

{ #category : #'api - testing' }
GtPharoTestSuite >> hasNotExecutedTestCases [

	self allNotExecutedTestCasesDo: [ ^ true ].
	^ false
]

{ #category : #'api - testing' }
GtPharoTestSuite >> hasPassedTestCases [

	self allPassedTestCasesDo: [ ^ true ].
	^ false
]

{ #category : #'api - testing' }
GtPharoTestSuite >> hasSelectedExecutableTestCases [

	self selectedExecutableTestCasesDo: [ :aCoder :aTestCase | ^ true ].
	^ false
]

{ #category : #'api - counts' }
GtPharoTestSuite >> numberOfAllPassedTestCases [

	| aCount |
	aCount := 0.
	self allPassedTestCasesDo: [ :aCoder :aTestCase | 
		aCount := aCount + 1 ].
	^ aCount
]

{ #category : #'api - counts' }
GtPharoTestSuite >> numberOfAllSkippedTestCases [

	| aCount |
	aCount := 0.
	self allSkippedTestCasesDo: [ :aCoder :aTestCase | 
		aCount := aCount + 1 ].
	^ aCount
]

{ #category : #'api - counts' }
GtPharoTestSuite >> numberOfAllTestCases [

	| aCount |
	aCount := 0.
	self allExecutableTestCasesDo: [ :aCoder :aTestCase | 
		aCount := aCount + 1 ].
	^ aCount
]

{ #category : #'api - counts' }
GtPharoTestSuite >> numberOfAllTestCasesWithState: aState [

	| aCount |
	aCount := 0.
	self allExecutableTestCasesDo: [ :aCoder :aTestCase | 
		aTestCase state = aState ifTrue: [ aCount := aCount + 1 ] ].
	^ aCount
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

{ #category : #'api - enumerating' }
GtPharoTestSuite >> selectedCodersDo: aBlock [

	self coder coders do: aBlock
]

{ #category : #'api - enumerating' }
GtPharoTestSuite >> selectedExecutableTestCasesDo: aBlock [

	self selectedCodersDo: [ :eachCoder | 
		eachCoder testCase canExecute ifTrue: [ 
			aBlock cull: eachCoder cull: eachCoder testCase ] ]
]
