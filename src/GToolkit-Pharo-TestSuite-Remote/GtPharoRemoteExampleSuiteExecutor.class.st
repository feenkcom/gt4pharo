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
GtPharoRemoteExampleSuiteExecutor >> playSelectedInMethodsCoder: aMethodsCoder [

	| isRunning |
	"Ensure Pharo Link is running"
	isRunning := GtPharoLinkCodeSync default isRunning.
	isRunning ifFalse: [ 
		GtPharoLinkCodeSync default stop.
		GtPharoLinkCodeSync default start ].

	aMethodsCoder exampler selectedExampleCodersDo: [ 
		:aCoder 
		:anExampleWithResult | 
		(aCoder isModified not and: [ 
			 anExampleWithResult hasNoTestPragma not ])
			ifTrue: [ 
				| aGroup aPromise aRemoteExample |
				aGroup := GtExampleGroup withAll:
					          { anExampleWithResult example asExampleWithResult }.
				
				aPromise := GtPharoLinkCodeSync default runExamples: aGroup.
				aRemoteExample := aPromise waitForValue.
				
				aRemoteExample isString ifTrue: [ 
					aRemoteExample := LanguageLinkUtils base64Decode:
						                  aRemoteExample readStream ].

				anExampleWithResult result: aRemoteExample examples anyOne result ]
			ifFalse: [ "anExample beSkipped" ] ]
]

{ #category : #'api - execution' }
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
