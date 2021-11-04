Class {
	#name : #GtPharoSuiteOverviewElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Test Case'
}

{ #category : #'examples - element' }
GtPharoSuiteOverviewElementExamples >> basicElement [

	<gtExample>
	| anElement |
	anElement := GtPharoSuiteOverviewElement new.

	self assert: anElement hasSuiteViewModel not.

	^ anElement
]

{ #category : #'examples - view model' }
GtPharoSuiteOverviewElementExamples >> basicTestSuiteViewModel [

	<gtExample>
	| aViewModel |
	aViewModel := GtPharoTestSuiteViewModel new.

	self assert: aViewModel allStates size isZero not.

	^ aViewModel
]

{ #category : #'examples - element' }
GtPharoSuiteOverviewElementExamples >> elementWithBasicTestSuite [

	<gtExample>
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
	| aViewModel aCoder |
	aViewModel := self testSuiteViewModelWithMethodsCoder.
	aViewModel executionState: #exception -> ZeroDivide new.

	self assert: aViewModel hasPendingExecution not.
	self assert: aViewModel hasExecutionError.

	^ aViewModel
]
