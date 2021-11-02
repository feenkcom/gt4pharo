Class {
	#name : #GtPharoRemoteExampleSuiteExecutor,
	#superclass : #Object,
	#traits : 'TGtPharoSuiteExecutor',
	#classTraits : 'TGtPharoSuiteExecutor classTrait',
	#category : #'GToolkit-Pharo-Coder-AddOns-Examples'
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
	isRunning ifFalse: [ GtPharoLinkCodeSync default start ].

	aMethodsCoder exampler selectedExampleCodersDo: [ 
		:aCoder 
		:anExampleWithResult | 
		(aCoder isModified not and: [ anExampleWithResult hasNoTestPragma not ])
			ifTrue: [ 
				| aGroup aPromise aRemoteExample |
				aGroup := GtExampleGroup withAll: { anExampleWithResult }.
				self halt.
				self flag: 'currently an issue if you proceed'.
				aPromise := GtPharoLinkCodeSync default runExamples: aGroup.
				aRemoteExample := aPromise waitForValue.
				self halt.
				aRemoteExample isString ifTrue: [ 
						aRemoteExample := LanguageLinkUtils base64Decode:
							               aRemoteExample readStream ].
					anExampleWithResult result: aRemoteExample ]
			ifFalse: [ "anExample beSkipped" ] ]
]
