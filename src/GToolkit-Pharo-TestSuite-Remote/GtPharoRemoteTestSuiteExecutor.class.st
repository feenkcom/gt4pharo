Class {
	#name : #GtPharoRemoteTestSuiteExecutor,
	#superclass : #Object,
	#traits : 'TGtPharoSuiteExecutor',
	#classTraits : 'TGtPharoSuiteExecutor classTrait',
	#category : #'GToolkit-Pharo-TestSuite-Remote'
}

{ #category : #'api - execution' }
GtPharoRemoteTestSuiteExecutor >> playStreamForSuiteStream: aSuiteCaseStream [
	"Execute a given test case / example"
	<return: #TAsyncStream>

	^ GtPharoRemoteTestSuiteStream new 
		sourceStream: aSuiteCaseStream;
		start
]
