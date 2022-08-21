Class {
	#name : #GtPharoCoderUIUtility,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #'instance creation' }
GtPharoCoderUIUtility class >> filteredMethodsPhlowViewFor: aView context: aPhlowContext filter: aGtSearchFilter testsRunner: shouldHaveTestsRunner examplesRunner: shouldHaveExamplesRunner [
	| aMethodsCoder aMethodsCoderViewModel  anItemsView |
	
	aMethodsCoder := GtPharoStreamingMethodsCoder forFilter: aGtSearchFilter.
	aMethodsCoderViewModel := (GtPharoStreamingMethodsCoderViewModel new 
		streamingCodersModel: aMethodsCoder)
			shouldExpandByDefault: false;
			shouldHaveHeaderByDefault: true.

	anItemsView := aView explicit
		title: 'Tests';
		stencil: [ GtPharoStreamingMethodsCoderElement new showIndicator 
			loadSinglesUntil: 20; 
			streamingCodersViewModel: aMethodsCoderViewModel  ].

	shouldHaveTestsRunner ifTrue: [
		| aTestSuite aTestSuiteViewModel aTestCommunicator |
		aTestSuite := GtPharoTestSuite new.
		aTestSuiteViewModel := GtPharoTestSuiteViewModel new pharoTestSuite: aTestSuite.
		aTestCommunicator := GtPharoExampleSuiteMethodsCoderCommunicator
					forMethodsCoder: aMethodsCoder
					suiteModel: aTestSuite
					viewModel: aTestSuiteViewModel.
		aPhlowContext optionAt: #exampleViewModelHandler put: aTestCommunicator.
		
		anItemsView
			actionStencil: [ GtPharoCoderUIUtility newTestsDropdownButtonForViewModel: aTestSuiteViewModel ] ].

	shouldHaveExamplesRunner ifTrue: [
		| anExampleSuite anExamplesSuiteViewModel anExampleCommunicator |
		anExampleSuite := GtPharoExampleSuite new.
		anExamplesSuiteViewModel := GtPharoExampleSuiteViewModel new pharoExampleSuite: anExampleSuite.
		anExampleCommunicator := GtPharoExampleSuiteMethodsCoderCommunicator
					forMethodsCoder: aMethodsCoder
					suiteModel: anExampleSuite
					viewModel: anExamplesSuiteViewModel.
		aPhlowContext optionAt: #exampleViewModelHandler put: anExampleCommunicator.
		
		anItemsView
			actionStencil: [ 
				GtPharoCoderUIUtility newExamplesDropdownButtonForViewModel: anExamplesSuiteViewModel ] ].

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
GtPharoCoderUIUtility class >> testMethodsPhlowViewFor: aView context: aPhlowContext filter: aGtSearchFilter [
	^ self
		filteredMethodsPhlowViewFor: aView
		context: aPhlowContext
		filter: aGtSearchFilter
		testsRunner: true
		examplesRunner: false
]
