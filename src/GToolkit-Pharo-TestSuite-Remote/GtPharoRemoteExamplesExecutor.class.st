Class {
	#name : #GtPharoRemoteExamplesExecutor,
	#superclass : #Object,
	#traits : 'TGtPharoSuiteExecutor',
	#classTraits : 'TGtPharoSuiteExecutor classTrait',
	#category : #'GToolkit-Pharo-TestSuite-Remote'
}

{ #category : #'api - testing' }
GtPharoRemoteExamplesExecutor >> isRemote [

	^ true
]

{ #category : #'api - execution' }
GtPharoRemoteExamplesExecutor >> playStreamForSuiteStream: aSuiteCaseStream [
	"Execute a given test case / example"
	<return: #TAsyncStream>

	^ GtPharoRemoteTestSuiteStream new 
		sourceStream: aSuiteCaseStream;
		start
]
