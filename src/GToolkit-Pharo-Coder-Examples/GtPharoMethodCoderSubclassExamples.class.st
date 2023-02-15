Class {
	#name : #GtPharoMethodCoderSubclassExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Coder - Method'
}

{ #category : #accessing }
GtPharoMethodCoderSubclassExamples >> testCaseAbstractClass [
	<gtExample>
	| coder gtPharoTestCase testSuite |

	coder := GtPharoMethodCoderSubclass
		forMethod: CollectionRootTest >> #testAllSatisfy
		className: #CollectionRootTest.
	gtPharoTestCase := coder testCase.
	self assert: gtPharoTestCase behavior name equals: #CollectionRootTest.
	self assert: gtPharoTestCase methodSelector equals: #testAllSatisfy.
	testSuite := gtPharoTestCase testCaseInstance.
	self assert: testSuite tests size equals: 25.
]

{ #category : #accessing }
GtPharoMethodCoderSubclassExamples >> testCaseConcreteClass [
	<gtExample>
	| coder gtPharoTestCase testSuite testCase |

	coder := GtPharoMethodCoderSubclass
		forMethod: CollectionRootTest >> #testAllSatisfy
		className: #ArrayTest.
	gtPharoTestCase := coder testCase.
	self assert: gtPharoTestCase behavior name equals: #ArrayTest.
	self assert: gtPharoTestCase methodSelector equals: #testAllSatisfy.
	testSuite := gtPharoTestCase testCaseInstance.
	self assert: testSuite tests size equals: 1.
	testCase := testSuite tests first.
	self assert: testCase selector equals: #testAllSatisfy.
	self assert: testCase class name equals: #ArrayTest.
]
