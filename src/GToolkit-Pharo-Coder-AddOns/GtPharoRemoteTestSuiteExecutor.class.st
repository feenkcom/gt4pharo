Class {
	#name : #GtPharoRemoteTestSuiteExecutor,
	#superclass : #Object,
	#traits : 'TGtPharoSuiteExecutor',
	#classTraits : 'TGtPharoSuiteExecutor classTrait',
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #'api - execution' }
GtPharoRemoteTestSuiteExecutor >> playSelectedInMethodsCoder: aMethodsCoder [

	"Execute test cases of a given methods coder"

	| isRunning |
	"Ensure Pharo Link is running"
	isRunning := GtPharoLinkCodeSync default isRunning.
	isRunning ifFalse: [ GtPharoLinkCodeSync default start ].

	aMethodsCoder testSuite selectedExecutableTestCasesDo: [ 
		:aCoder 
		:aTestCase | 
		(aCoder isModified not and: [ aTestCase hasNoTestPragma not ])
			ifTrue: [ 
				| aSuite aPromise aTestResult |
				aSuite := aTestCase testCaseInstance.
				aPromise := GtPharoLinkCodeSync default runTests: aSuite.
				aTestResult := aPromise waitForValue.
				aPromise exception ifNil: [ 
					aTestResult isString ifTrue: [ 
						aTestResult := LanguageLinkUtils base64Decode:
							               aTestResult readStream ].
					aTestCase result: aTestResult ] ]
			ifFalse: [ aTestCase beSkipped ] ]
]
