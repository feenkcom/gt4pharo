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

{ #category : #accessing }
GtPharoSuiteOverviewElementExamples >> testSuiteViewModelWithMethodsCoder [

	<gtExample>
	| aViewModel aCoder |
	aViewModel := GtPharoTestSuiteViewModel new.
	aCoder := self methodsCoderWithTestCase.
	aViewModel coder: aCoder.

	self assert: aViewModel coder equals: aCoder.

	^ aViewModel
]
