Class {
	#name : #GtPharoRemoteExampleSuiteExecutor,
	#superclass : #Object,
	#traits : 'TGtPharoSuiteExecutor',
	#classTraits : 'TGtPharoSuiteExecutor classTrait',
	#category : #'GToolkit-Pharo-TestSuite-Remote'
}

{ #category : #'api - testing' }
GtPharoRemoteExampleSuiteExecutor >> isRemote [

	^ true
]

{ #category : #'api - execution' }
GtPharoRemoteExampleSuiteExecutor >> playStreamForSuiteStream: aSuiteCaseStream [

	"Execute a given test case / example"

	<return: #TAsyncStream>
	^ aSuiteCaseStream map: [ :anExample | 
		  self playSuiteCase: anExample.
		  anExample ]
]

{ #category : #'private - execution' }
GtPharoRemoteExampleSuiteExecutor >> playSuiteCase: anExample [

	| isRunning |
	"Ensure Pharo Link is running"
	isRunning := GtPharoLinkCodeSync default isRunning.
	isRunning ifFalse: [ 
		GtPharoLinkCodeSync default stop.
		GtPharoLinkCodeSync default start ].
	anExample hasNoTestPragma
		ifTrue: [ "anExample beSkipped" ]
		ifFalse: [ 
			| aGroup aPromise aRemoteExample |
			aGroup := GtExampleGroup withAll: { anExample }.
			aPromise := GtPharoLinkCodeSync default runExamples: aGroup.
			aRemoteExample := aPromise waitForValue.
			aRemoteExample isString ifTrue: [ 
				aRemoteExample := LanguageLinkUtils base64Decode:
					                  aRemoteExample readStream ].
			anExample result: aRemoteExample examples anyOne result ]
]
