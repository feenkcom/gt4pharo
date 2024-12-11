Class {
	#name : #GtPharoCoderUIUtility,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #'instance creation' }
GtPharoCoderUIUtility class >> exampleViewModelCachedAs: aSymbol inPhlowContext: aPhlowContext [
	<return: #GtPharoExampleSuiteViewModel>
	^ aPhlowContext
		optionAt: aSymbol
		ifPresent: [ :anExampleViewModel | anExampleViewModel ]
		ifAbsentPut: [ | aSuiteModel aViewModel |
			aSuiteModel := GtPharoExampleSuite new.
			aViewModel := GtPharoExampleSuiteViewModel new pharoExampleSuite: aSuiteModel.

			aViewModel ]
]

{ #category : #'instance creation' }
GtPharoCoderUIUtility class >> exampleViewModelCachedAs: aSymbol inPhlowContext: aPhlowContext forMethodsCoder: aMethodsCoder [
	<return: #GtPharoExampleSuiteViewModel>
	^ aPhlowContext
		optionAt: aSymbol
		ifPresent: [ :anExampleViewModel | 
			aMethodsCoder exampleSuite: anExampleViewModel pharoExampleSuite.
			anExampleViewModel ]
		ifAbsent: [ | aViewModel aHandler |
			aViewModel := self
					exampleViewModelCachedAs: aSymbol
					inPhlowContext: aPhlowContext.
			aMethodsCoder exampleSuite: aViewModel pharoExampleSuite.

			aHandler := GtPharoExampleSuiteMethodsCoderMediator
					forMethodsCoder: aMethodsCoder
					suiteModel: aViewModel pharoExampleSuite
					viewModel: aViewModel.
			aPhlowContext optionAt: (aSymbol , #_handler) asSymbol put: aHandler.

			aViewModel ]
]

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
		aMethodsCoder testSuite: aTestSuite.
		aTestSuiteViewModel := GtPharoTestSuiteViewModel new pharoTestSuite: aTestSuite.
		aTestCommunicator := GtPharoTestSuiteMethodsCoderMediator
					forMethodsCoder: aMethodsCoder
					suiteModel: aTestSuite
					viewModel: aTestSuiteViewModel.
		aPhlowContext optionAt: #testViewModelHandler put: aTestCommunicator.
		
		anItemsView
			actionStencil: [ GtPharoCoderUIUtility newTestsDropdownButtonForViewModel: aTestSuiteViewModel ] ].

	shouldHaveExamplesRunner ifTrue: [
		| anExampleSuite anExamplesSuiteViewModel anExampleCommunicator |
		anExampleSuite := GtPharoExampleSuite new.
		aMethodsCoder exampleSuite: anExampleSuite.
		anExamplesSuiteViewModel := GtPharoExampleSuiteViewModel new pharoExampleSuite: anExampleSuite.
		anExampleCommunicator := GtPharoExampleSuiteMethodsCoderMediator
					forMethodsCoder: aMethodsCoder
					suiteModel: anExampleSuite
					viewModel: anExamplesSuiteViewModel.
		aPhlowContext optionAt: #exampleViewModelHandler put: anExampleCommunicator.
		
		anItemsView
			actionStencil: [ 
				GtPharoCoderUIUtility newExamplesDropdownButtonForViewModel: anExamplesSuiteViewModel ] ].

		anItemsView 
			actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'UI filter' 
			tooltip: 'Inspect the current search filter'
			action: [ :aButton |
				aButton phlow spawnObject: (aButton phlow viewContent query // GtPharoStreamingMethodsCoderElement) anyOne streamingCodersViewModel streamingCodersModel compositeFilter ].
				
	^ anItemsView
]

{ #category : #'instance creation' }
GtPharoCoderUIUtility class >> newExamplesDropdownButtonForViewModel: aViewModel [
	^ GtPharoSuiteShowButton new
		id: GtPharoExampleSuiteShowButtonId;
		label: 'Run Examples';
		suiteViewModel: aViewModel;
		yourself
]

{ #category : #'instance creation' }
GtPharoCoderUIUtility class >> newTestsDropdownButtonForViewModel: aViewModel [
	^ GtPharoSuiteShowButton new
		id: GtPharoTestSuiteShowButtonId;
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
