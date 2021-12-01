Class {
	#name : #GtPharoMethodsCoderView,
	#superclass : #Object,
	#instVars : [
		'filter',
		'shouldHaveTestsRunner',
		'shouldHaveExamplesRunner'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! Views'
}

{ #category : #accessing }
GtPharoMethodsCoderView >> filter [

	^ filter
]

{ #category : #accessing }
GtPharoMethodsCoderView >> filter: anObject [

	filter := anObject
]

{ #category : #accessing }
GtPharoMethodsCoderView >> gtMethodsFor: aView [
	| aMethodsCoder aMethodsCoderViewModel  anItemsView |
	<gtView>

	aMethodsCoder := GtPharoStreamingBehaviorMethodsCoder forFilter: filter.
	aMethodsCoderViewModel := (GtPharoStreamingMethodsCoderViewModel new streamingCodersModel: aMethodsCoder)
		shouldExpandByDefault: false;
		shouldHaveHeaderByDefault: true.

	anItemsView := aView explicit
		title: 'Methods';
		priority: 10;
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

{ #category : #initialization }
GtPharoMethodsCoderView >> initialize [
	super initialize.
	
	shouldHaveTestsRunner := true.
	shouldHaveExamplesRunner := true
]

{ #category : #accessing }
GtPharoMethodsCoderView >> shouldHaveExamplesRunner [

	^ shouldHaveExamplesRunner
]

{ #category : #accessing }
GtPharoMethodsCoderView >> shouldHaveExamplesRunner: anObject [

	shouldHaveExamplesRunner := anObject
]

{ #category : #accessing }
GtPharoMethodsCoderView >> shouldHaveTestsRunner [

	^ shouldHaveTestsRunner
]

{ #category : #accessing }
GtPharoMethodsCoderView >> shouldHaveTestsRunner: anObject [

	shouldHaveTestsRunner := anObject
]
