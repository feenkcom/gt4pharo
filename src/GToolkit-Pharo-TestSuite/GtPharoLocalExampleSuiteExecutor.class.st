Class {
	#name : #GtPharoLocalExampleSuiteExecutor,
	#superclass : #Object,
	#traits : 'TGtPharoSuiteExecutor',
	#classTraits : 'TGtPharoSuiteExecutor classTrait',
	#category : 'GToolkit-Pharo-TestSuite-Executor'
}

{ #category : #'api - testing' }
GtPharoLocalExampleSuiteExecutor >> isLocal [

	^ true
]

{ #category : #'api - execution' }
GtPharoLocalExampleSuiteExecutor >> playStreamForSuiteStream: aSuiteCaseStream [

	"Execute a given test case / example"

	<return: #TAsyncStream>
	^ aSuiteCaseStream map: [ :aSuiteCase | 
		  self playSuiteCase: aSuiteCase.
		  aSuiteCase ]
]

{ #category : #'private - execution' }
GtPharoLocalExampleSuiteExecutor >> playSuiteCase: aSuiteCase [
	"Execute a given test case / example"
	
	aSuiteCase hasNoTestPragma
		ifFalse: [ aSuiteCase run ]
]
