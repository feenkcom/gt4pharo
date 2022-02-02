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
	"| job |

	job := GtRrTestsJob fromTestCaseAsyncStream: aSuiteCaseStream.
	GtRemoteRunner default submitJob: job.
	^ job asAsyncStream."

	^ GtPharoRemoteTestSuiteStream new 
		sourceStream: aSuiteCaseStream;
		start
]

{ #category : #'private - execution' }
GtPharoRemoteTestSuiteExecutor >> playSuiteCase: aTestCase [
	"Execute a given test case / example"
	| isRunning |

	"Ensure Pharo Link is running"
	isRunning := GtPharoLinkCodeSync default isRunning.
	isRunning ifFalse: [ 
		GtPharoLinkCodeSync default stop.
		GtPharoLinkCodeSync default start ].

	(aTestCase hasNoTestPragma not)
		ifTrue: [ 
			| aSuite aPromise aTestResult |
			aSuite := aTestCase testCaseInstance.
			aPromise := GtPharoLinkCodeSync default runTests: aSuite.
			aTestResult := aPromise waitForValue.
			aPromise exception ifNil: [ 
				aTestResult isString ifTrue: [ 
					aTestResult := LanguageLinkUtils base64Decode: aTestResult readStream ].
				aTestCase result: aTestResult ] ]
		ifFalse: [ aTestCase beSkipped ]
]
