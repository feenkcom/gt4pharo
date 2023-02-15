Class {
	#name : #GtPharoMethodTestCaseSubclassExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-TestSuite-Examples'
}

{ #category : #accessing }
GtPharoMethodTestCaseSubclassExamples >> behaviorConcreteClass [
	<gtExample>
	| gtPharoTestCase testSuite testCase |

	gtPharoTestCase := GtPharoMethodTestCaseSubclass
		forMethod: CollectionRootTest >> #testAllSatisfy
		className: #ArrayTest.
	self assert: gtPharoTestCase behavior equals: ArrayTest.
	testSuite := gtPharoTestCase testCaseInstance.
	self assert: testSuite tests size equals: 1.
	testCase := testSuite tests first.
	self assert: testCase selector equals: #testAllSatisfy.
	self assert: testCase class name equals: #ArrayTest.
]

{ #category : #accessing }
GtPharoMethodTestCaseSubclassExamples >> testCaseAbstractClass [
	<gtExample>
	| gtPharoTestCase testSuite |

	gtPharoTestCase := GtPharoMethodTestCaseSubclass
		forMethod: CollectionRootTest >> #testAllSatisfy
		className: #CollectionRootTest.
	self assert: gtPharoTestCase behavior name equals: #CollectionRootTest.
	self assert: gtPharoTestCase methodSelector equals: #testAllSatisfy.
	testSuite := gtPharoTestCase testCaseInstance.
	self assert: testSuite tests size equals: 25.
]
