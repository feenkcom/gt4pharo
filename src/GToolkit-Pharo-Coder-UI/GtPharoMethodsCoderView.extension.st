Extension { #name : #GtPharoMethodsCoderView }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoMethodsCoderView >> gtMethodsFor: aView [
	| aMethodsCoder aMethodsCoderViewModel  anItemsView |
	<gtView>

	aMethodsCoder := GtPharoStreamingMethodsCoder forFilter: filter.
	aMethodsCoderViewModel := (GtPharoStreamingMethodsCoderViewModel new 
		streamingCodersModel: aMethodsCoder)
			shouldExpandByDefault: false;
			shouldHaveHeaderByDefault: true.

	anItemsView := aView explicit
		title: 'Methods';
		priority: 10;
		stencil: [ 
			GtPharoStreamingMethodsCoderElement new 
				streamingCodersViewModel: aMethodsCoderViewModel ].

	shouldHaveTestsRunner ifTrue: [
		| aTestSuiteViewModel |
		aTestSuiteViewModel := GtPharoTestSuiteViewModel new 
			pharoTestSuite: (GtPharoTestSuite forStream: aMethodsCoder itemsStream).
		aMethodsCoder testSuite: aTestSuiteViewModel pharoTestSuite.
		anItemsView
			actionStencil: [ 
				GtPharoCoderUIUtility newTestsDropdownButtonForViewModel: aTestSuiteViewModel ] ].

	shouldHaveExamplesRunner ifTrue: [
		| anExamplesSuiteViewModel |
		anExamplesSuiteViewModel := GtPharoExampleSuiteViewModel new 
			pharoExampleSuite: (GtPharoExampleSuite forStream: aMethodsCoder itemsStream).
		aMethodsCoder exampleSuite: anExamplesSuiteViewModel pharoExampleSuite.
		anItemsView
			actionStencil: [ 
				GtPharoCoderUIUtility newExamplesDropdownButtonForViewModel: anExamplesSuiteViewModel ] ].

	^ anItemsView
]
