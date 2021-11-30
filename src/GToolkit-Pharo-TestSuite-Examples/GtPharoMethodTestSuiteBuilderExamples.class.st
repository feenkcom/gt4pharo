"
I exemplify {{gtClass:GtPharoMethodTestSuiteBuilder}}.

"
Class {
	#name : #GtPharoMethodTestSuiteBuilderExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-TestSuite-Examples'
}

{ #category : #examples }
GtPharoMethodTestSuiteBuilderExamples >> basicBuilder [

	<gtExample>
	| aBuilder |
	aBuilder := GtPharoMethodTestSuiteBuilder new.

	^ aBuilder
]

{ #category : #examples }
GtPharoMethodTestSuiteBuilderExamples >> builderWithAbstractClass [

	<gtExample>
	| aBuilder |
	aBuilder := self basicBuilder.
	aBuilder behavior: GtPharoDummyAbstractTestCase.

	self assert: aBuilder behavior equals: GtPharoDummyAbstractTestCase.

	^ aBuilder
]

{ #category : #accessing }
GtPharoMethodTestSuiteBuilderExamples >> builderWithAbstractClassAndTestCallingFoo [

	<gtExample>
	| aBuilder |
	aBuilder := self builderWithAbstractClass.
	aBuilder selector: #testCallingFoo.

	self assert: aBuilder selector equals: #testCallingFoo.

	^ aBuilder
]

{ #category : #examples }
GtPharoMethodTestSuiteBuilderExamples >> testResultFromAbstractClassAndTestCallingFoo [

	<gtExample>
	| aTestSuite aResult |
	aTestSuite := self testSuiteFromAbstractClassAndTestCallingFoo.
	aResult := aTestSuite run.

	^ aResult
]

{ #category : #examples }
GtPharoMethodTestSuiteBuilderExamples >> testSuiteFromAbstractClassAndTestCallingFoo [

	<gtExample>
	| aBuilder aTestSuite |
	aBuilder := self builderWithAbstractClassAndTestCallingFoo.
	aTestSuite := aBuilder build.

	self assert: aTestSuite tests size equals: 2.
	self assert: (aTestSuite tests allSatisfy: [ :aTestCase | 
			 aTestCase selector = aBuilder selector ]).
	self
		assert: (aTestSuite tests collect: #class)
		equals: aBuilder behavior allSubclasses.

	self assert: aTestSuite gtAllCompiledMethods size equals: 1.
	self
		assert: aTestSuite gtAllCompiledMethods anyOne
		equals: aBuilder behavior >> aBuilder selector.

	^ aTestSuite
]
