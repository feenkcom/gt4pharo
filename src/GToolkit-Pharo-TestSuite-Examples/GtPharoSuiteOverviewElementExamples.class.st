Class {
	#name : #GtPharoSuiteOverviewElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-TestSuite-Examples'
}

{ #category : #'examples - element' }
GtPharoSuiteOverviewElementExamples >> basicElement [
	<gtExample>
	<noTest>
	| anElement |
	
	anElement := GtPharoSuiteOverviewElement new.

	self assert: anElement hasSuiteViewModel not.

	^ anElement
]

{ #category : #'examples - view model' }
GtPharoSuiteOverviewElementExamples >> basicTestSuiteViewModel [
	<gtExample>
	<noTest>
	| aViewModel |
	aViewModel := GtPharoTestSuiteViewModel new.

	self assert: aViewModel allStates size isZero not.

	^ aViewModel
]

{ #category : #'examples - element' }
GtPharoSuiteOverviewElementExamples >> elementWithBasicTestSuite [
	<gtExample>
	<noTest>
	| aViewModel anElement |
	anElement := self basicElement.
	aViewModel := self basicTestSuiteViewModel.

	anElement suiteViewModel: aViewModel.

	self assert: anElement hasSuiteViewModel.
	self assert: anElement suiteViewModel == aViewModel.

	^ anElement
]

{ #category : #'examples - element' }
GtPharoSuiteOverviewElementExamples >> elementWithTestSuiteWithMethodsCoder [
	<gtExample>
	<noTest>
	| aViewModel anElement |
	anElement := self basicElement.
	aViewModel := self testSuiteViewModelWithMethodsCoder.

	anElement suiteViewModel: aViewModel.

	self assert: anElement hasSuiteViewModel.
	self assert: anElement suiteViewModel == aViewModel.

	^ anElement
]

{ #category : #accessing }
GtPharoSuiteOverviewElementExamples >> elementWithTestSuiteWithMethodsCoderAndExecutionError [
	<gtExample>
	<noTest>
	| aViewModel anElement |
	anElement := self basicElement.
	aViewModel := self testSuiteViewModelWithMethodsCoderAndExecutionError.

	anElement suiteViewModel: aViewModel.

	self assert: anElement hasSuiteViewModel.
	self assert: anElement suiteViewModel == aViewModel.

	^ anElement
]

{ #category : #'examples - coder' }
GtPharoSuiteOverviewElementExamples >> methodsCoderWithTestCase [
	<gtExample>
	<noTest>
	| aCoder |
	aCoder := GtClassMethodsCoder forClass: GtPharoDummyTestCase.
	
	self
		assert: aCoder coders size > 1
		description: [ 'There must be some method coders' ].

	^ aCoder
]

{ #category : #'examples - view model' }
GtPharoSuiteOverviewElementExamples >> testSuiteViewModelWithMethodsCoder [
	<gtExample>
	<noTest>
	| aViewModel aCoder |
	aViewModel := self basicTestSuiteViewModel.
	aCoder := self methodsCoderWithTestCase.
	aViewModel methodsCoderModel: aCoder.

	self assert: aViewModel methodsCoderModel equals: aCoder.

	^ aViewModel
]

{ #category : #'examples - view model' }
GtPharoSuiteOverviewElementExamples >> testSuiteViewModelWithMethodsCoderAndExecutionError [
	<gtExample>
	<noTest>
	| aViewModel |
	aViewModel := self testSuiteViewModelWithMethodsCoder.
	aViewModel executionState: #exception -> ZeroDivide new.

	self assert: aViewModel hasPendingExecution not.
	self assert: aViewModel hasExecutionError.

	^ aViewModel
]
