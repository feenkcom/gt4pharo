Class {
	#name : #GtPharoMethodTestSuiteBuilder,
	#superclass : #Object,
	#instVars : [
		'behavior',
		'selector',
		'testSuite'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #accessing }
GtPharoMethodTestSuiteBuilder >> behavior [

	^ behavior
]

{ #category : #accessing }
GtPharoMethodTestSuiteBuilder >> behavior: aTestCaseClass [

	self
		assert: [ aTestCaseClass isTestCase ]
		description: [ 'Behavior must  be a test case class' ].

	behavior := aTestCaseClass
]

{ #category : #building }
GtPharoMethodTestSuiteBuilder >> build [

	testSuite := self behavior suiteClass new.
	testSuite name: self behavior name , ' >> #' , self selector asString.

	self behavior withAllSubclassesDo: [ :aClass | 
		aClass isAbstract ifFalse: [ 
			| aTestCase |
			aTestCase := aClass selector: self selector.
			testSuite addTest: aTestCase ] ].

	^ testSuite
]

{ #category : #accessing }
GtPharoMethodTestSuiteBuilder >> selector [

	^ selector
]

{ #category : #accessing }
GtPharoMethodTestSuiteBuilder >> selector: aSymbol [

	self
		assert: [ aSymbol isSymbol ]
		description: [ 'Selector must be a symbol' ].
	self
		assert: [ aSymbol isTestSelector ]
		description: [ 'Selector must be a test selector' ].
		
	selector := aSymbol
]
