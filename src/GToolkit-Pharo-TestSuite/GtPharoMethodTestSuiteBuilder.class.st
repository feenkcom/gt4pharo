"
I create {{gtClass:TestCase}} instances for a given class and test case selector. 
I return {{gtClass:TestSuite}}.
#Example
##TestSuite
For a given abstract class and test case selector, I collect concrete test case subclasses with the assigned test case selector: {{gtExample:GtPharoMethodTestSuiteBuilderExamples >> #testSuiteFromAbstractClassAndTestCallingFoo | codeExpanded=false | previewExpanded= true | previewHeight=200}}
#TestResult
In the example above, we see one method source code and two test cases. If the test suite is executed, we obtain the following result: {{gtExample:GtPharoMethodTestSuiteBuilderExamples >> #testResultFromAbstractClassAndTestCallingFoo | codeExpanded=false | previewExpanded=true }}
"
Class {
	#name : #GtPharoMethodTestSuiteBuilder,
	#superclass : #Object,
	#instVars : [
		'behavior',
		'selector',
		'testSuite'
	],
	#category : 'GToolkit-Pharo-TestSuite-Base'
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
