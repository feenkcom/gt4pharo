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

	self executableTestCasesDo: [ :aCoder :aTestCase | 
		aTestCase state = GtPharoMethodTestCaseErrorState default ifTrue: [ 
			aBlock cull: aCoder cull: aTestCase ] ]
]

{ #category : #'api - enumerating' }
GtPharoTestSuite >> allFailureTestCasesDo: aBlock [

	self executableTestCasesDo: [ :aCoder :aTestCase | 
		aTestCase state = GtPharoMethodTestCaseFailureState default ifTrue: [ 
			aBlock cull: aCoder cull: aTestCase ] ] 
]

{ #category : #'api - enumerating' }
GtPharoTestSuite >> allNotExecutedTestCasesDo: aBlock [

	self executableTestCasesDo: [ :aCoder :aTestCase | 
		aTestCase state = GtPharoMethodNotExecutedState default ifTrue: [ 
			aBlock cull: aCoder cull: aTestCase ] ]
]

{ #category : #'api - enumerating' }
GtPharoTestSuite >> allPassedTestCasesDo: aBlock [

	self executableTestCasesDo: [ :aCoder :aTestCase | 
		aTestCase state = GtPharoMethodTestCasePassedState default ifTrue: [ 
			aBlock cull: aCoder cull: aTestCase ] ]  
]

{ #category : #'api - accessing' }
GtPharoTestSuite >> allTestCaseStates [

	| aSet |
	aSet := Set new.

	self executableTestCasesDo: [ :aCoder :aTestCase | 
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

{ #category : #'api - enumerating' }
GtPharoTestSuite >> executableTestCasesDo: aBlock [

	self allCodersDo: [ :eachCoder | 
		eachCoder testCase canExecute ifTrue: [ 
			aBlock cull: eachCoder cull: eachCoder testCase ] ]
]

{ #category : #'api - testing' }
GtPharoTestSuite >> hasErrorTestCases [

	self allErrorTestCasesDo: [ ^ true ].
	^ false
]

{ #category : #'api - testing' }
GtPharoTestSuite >> hasExecutableTestCases [

	self executableTestCasesDo: [ :aCoder :aTestCase | ^ true ].
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

{ #category : #'api - execution' }
GtPharoTestSuite >> playSelected [

	self selectedExecutableTestCasesDo: [ :aCoder :aTestCase | 
		(aCoder isModified not and: [ aTestCase hasNoTestPragma not ]) 
			ifTrue: [ aTestCase play ] ]
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
