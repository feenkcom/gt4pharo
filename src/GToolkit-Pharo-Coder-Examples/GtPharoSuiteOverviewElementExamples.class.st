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
GtPharoSuiteOverviewElementExamples >> elementWithTestSuite [

	<gtExample>
	| aViewModel anElement |
	anElement := self basicElement.
	aViewModel := self basicTestSuiteViewModel.

	anElement suiteViewModel: aViewModel.

	self assert: anElement hasSuiteViewModel.
	self assert: anElement suiteViewModel == aViewModel.

	^ anElement
]
