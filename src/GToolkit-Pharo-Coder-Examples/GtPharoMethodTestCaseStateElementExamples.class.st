Class {
	#name : #GtPharoMethodTestCaseStateElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Test Case'
}

{ #category : #asserting }
GtPharoMethodTestCaseStateElementExamples >> assert: anElement backgroundColor: aColor [ 
	self
		assert: anElement background class 
		equals: BlPaintBackground.
	self
		assert: anElement background paint class 
		equals: BlColorPaint.
	self
		assert: anElement background paint color 
		equals: aColor.
]

{ #category : #accessing }
GtPharoMethodTestCaseStateElementExamples >> basicStateElement [
	<gtExample>
	| anElement |
	anElement := GtPharoMethodTestCaseStateElement new.
	self assert: anElement testCase isNil.
	^ anElement
]

{ #category : #accessing }
GtPharoMethodTestCaseStateElementExamples >> passingTestCase [

	<gtExample>
	^ GtPharoMethodTestCaseExamples new passedOneUnitTestPharoMethodCoder
		  testCase
]

{ #category : #accessing }
GtPharoMethodTestCaseStateElementExamples >> stateElement_NotExecuted [
	<gtExample>
	| anElement aTestCase |
	anElement := self basicStateElement.
	aTestCase := self passingTestCase.
	anElement testCase: aTestCase.
	self assert: anElement testCase equals: aTestCase.
	self assert: anElement testResult isNil.
	self 
		assert: anElement 
		backgroundColor: GtPharoMethodNotExecutedState default color.
	^ anElement
]

{ #category : #accessing }
GtPharoMethodTestCaseStateElementExamples >> stateElement_Success [
	<gtExample>
	| anElement aTestCase |
	anElement := self stateElement_NotExecuted.
	aTestCase := anElement testCase.
	BlUseAsyncFeatures disableDuring: [
		aTestCase play ].
	self assert: anElement testCase isPassed.
	self 
		assert: anElement 
		backgroundColor: GtPharoMethodTestCasePassedState default color.
	^ anElement
]
