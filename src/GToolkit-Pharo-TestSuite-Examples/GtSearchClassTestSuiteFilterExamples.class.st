Class {
	#name : #GtSearchClassTestSuiteFilterExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-TestSuite-Examples'
}

{ #category : #'examples - filter' }
GtSearchClassTestSuiteFilterExamples >> basicFilter [

	<gtExample>
	| aFilter |
	aFilter := GtSearchClassTestSuiteFilter new.
	
	self
		assert: aFilter testCaseClass isNotNil
		description: [ 'Filter must have initialized test case class' ].
		
	^ aFilter
]

{ #category : #'examples - filter' }
GtSearchClassTestSuiteFilterExamples >> filterWithDummySubTestCaseClass [

	<gtExample>
	| aFilter |
	aFilter := self basicFilter.
	aFilter testCaseClass: GtPharoDummySubTestCase.

	self assert: aFilter testCaseClass equals: GtPharoDummySubTestCase.

	^ aFilter
]

{ #category : #'examples - filter' }
GtSearchClassTestSuiteFilterExamples >> filterWithDummyTestCaseClass [

	<gtExample>
	| aFilter |
	aFilter := self basicFilter.
	aFilter testCaseClass: GtPharoDummyTestCase.

	self assert: aFilter testCaseClass equals: GtPharoDummyTestCase.

	^ aFilter
]

{ #category : #'examples - including method' }
GtSearchClassTestSuiteFilterExamples >> includesObjectShouldNotImplementMethod [

	<gtExample>
	| aFilter aResult aCompiledMethod |
	aFilter := self filterWithDummyTestCaseClass.
	aCompiledMethod := Object >> #shouldNotImplement.

	aResult := aFilter includesMethod: aCompiledMethod.
	self
		assert: aResult not
		description: [ 'Filter must not include ' , aCompiledMethod asString ].

	^ aFilter
]

{ #category : #'examples - including method' }
GtSearchClassTestSuiteFilterExamples >> includesSameClassNonTestCaseMethod [

	<gtExample>
	| aFilter aResult aCompiledMethod |
	aFilter := self filterWithDummyTestCaseClass.
	aCompiledMethod := GtPharoDummyTestCase >> #setUp.

	aResult := aFilter includesMethod: aCompiledMethod.
	self
		assert: aResult not
		description: [ 'Filter must not include ' , aCompiledMethod asString ].

	^ aFilter
]

{ #category : #'examples - including method' }
GtSearchClassTestSuiteFilterExamples >> includesSameClassTestCaseMethod [

	<gtExample>
	| aFilter aResult aCompiledMethod |
	aFilter := self filterWithDummyTestCaseClass.
	aCompiledMethod := GtPharoDummyTestCase >> #testNewOne.

	aResult := aFilter includesMethod: aCompiledMethod.
	self
		assert: aResult
		description: [ 'Filter must include ' , aCompiledMethod asString ].

	^ aFilter
]

{ #category : #'examples - including method' }
GtSearchClassTestSuiteFilterExamples >> includesSubClassTestCaseMethod [

	<gtExample>
	| aFilter aResult aCompiledMethod |
	aFilter := self filterWithDummyTestCaseClass.
	aCompiledMethod := GtPharoDummySubTestCase >> #testSubOne.

	aResult := aFilter includesMethod: aCompiledMethod.
	self
		assert: aResult
		description: [ 'Filter must include ' , aCompiledMethod asString ].

	^ aFilter
]

{ #category : #'examples - including method' }
GtSearchClassTestSuiteFilterExamples >> includesSuperClassTestCaseMethod [

	<gtExample>
	| aFilter aResult aCompiledMethod |
	aFilter := self filterWithDummySubTestCaseClass.
	aCompiledMethod := GtPharoDummyTestCase >> #testNewOne.

	aResult := aFilter includesMethod: aCompiledMethod.
	self
		assert: aResult
		description: [ 'Filter must include ' , aCompiledMethod asString ].

	^ aFilter
]

{ #category : #'examples - including method' }
GtSearchClassTestSuiteFilterExamples >> includesTestCaseShouldMethod [

	<gtExample>
	| aFilter aResult aCompiledMethod |
	aFilter := self filterWithDummyTestCaseClass.
	aCompiledMethod := TestCase >> #shouldAnnounce.

	aResult := aFilter includesMethod: aCompiledMethod.
	self
		assert: aResult not
		description: [ 'Filter must not include ' , aCompiledMethod asString ].

	^ aFilter
]
