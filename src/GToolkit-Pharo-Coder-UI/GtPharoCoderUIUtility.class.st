Class {
	#name : #GtPharoCoderUIUtility,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #'instance creation' }
GtPharoCoderUIUtility class >> filteredMethodsPhlowViewFor: aView filter: aGtSearchFilter testsRunner: shouldHaveTestsRunner examplesRunner: shouldHaveExamplesRunner [
	| aMethodsCoder aMethodsCoderViewModel  anItemsView |
	
	aMethodsCoder := GtPharoStreamingBehaviorMethodsCoder forFilter: aGtSearchFilter.
	aMethodsCoderViewModel := (GtPharoStreamingMethodsCoderViewModel new streamingCodersModel: aMethodsCoder)
		shouldExpandByDefault: false;
		shouldHaveHeaderByDefault: true.

	anItemsView := aView explicit
		title: 'Tests';
		stencil: [ GtPharoStreamingMethodsCoderElement new streamingCodersViewModel: aMethodsCoderViewModel ].

	shouldHaveTestsRunner ifTrue: [
		| aTestSuiteViewModel |
		aTestSuiteViewModel := GtPharoTestSuiteViewModel new pharoTestSuite: (GtPharoTestSuite forStream: aMethodsCoder itemsStream).
		anItemsView
			actionStencil: [ GtPharoCoderUIUtility newTestsDropdownButtonForViewModel: aTestSuiteViewModel ] ].

	shouldHaveExamplesRunner ifTrue: [
		| anExamplesSuiteViewModel |
		anExamplesSuiteViewModel := GtPharoExampleSuiteViewModel new pharoExampleSuite: (GtPharoExampleSuite forStream: aMethodsCoder itemsStream).
		anItemsView
			actionStencil: [ GtPharoCoderUIUtility newExamplesDropdownButtonForViewModel: anExamplesSuiteViewModel ] ].

	^ anItemsView
]

{ #category : #'instance creation' }
GtPharoCoderUIUtility class >> newExamplesDropdownButtonForViewModel: aViewModel [
	^ GtPharoSuiteShowButton new
		label: 'Run Examples';
		suiteViewModel: aViewModel;
		yourself
]

{ #category : #'instance creation' }
GtPharoCoderUIUtility class >> newTestsDropdownButtonForViewModel: aViewModel [
	^ GtPharoSuiteShowButton new
		label: 'Run Tests';
		suiteViewModel: aViewModel;
		yourself
]

{ #category : #'instance creation' }
GtPharoCoderUIUtility class >> testMethodsPhlowViewFor: aView filter: aGtSearchFilter [
	^ self
		filteredMethodsPhlowViewFor: aView
		filter: aGtSearchFilter
		testsRunner: true
		examplesRunner: false
]
