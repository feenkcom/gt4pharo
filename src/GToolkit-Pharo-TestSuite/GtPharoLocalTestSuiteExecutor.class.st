Class {
	#name : #GtPharoLocalTestSuiteExecutor,
	#superclass : #Object,
	#traits : 'TGtPharoSuiteExecutor',
	#classTraits : 'TGtPharoSuiteExecutor classTrait',
	#category : #'GToolkit-Pharo-TestSuite-Executor'
}

{ #category : #'api - testing' }
GtPharoLocalTestSuiteExecutor >> isLocal [

	^ true
]

{ #category : #'api - execution' }
GtPharoLocalTestSuiteExecutor >> playSelectedInMethodsCoder: aTestSuite [

	"Execute test cases of a given methods coder"
	aTestSuite playSelected
]

{ #category : #'api - execution' }
GtPharoLocalTestSuiteExecutor >> playStreamForSuiteStream: aSuiteCaseStream [

	"Execute a given test case / example"

	<return: #TAsyncStream>
	^ aSuiteCaseStream map: [ :aSuiteCase | 
		  self playSuiteCase: aSuiteCase ]
]

{ #category : #'private - execution' }
GtPharoLocalTestSuiteExecutor >> playSuiteCase: aSuiteCase [

	aSuiteCase hasNoTestPragma
		ifFalse: [ aSuiteCase play ]
		ifTrue: [ aSuiteCase beSkipped ].

	^ aSuiteCase
]
