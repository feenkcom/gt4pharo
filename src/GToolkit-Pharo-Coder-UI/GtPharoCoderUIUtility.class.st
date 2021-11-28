Class {
	#name : #GtPharoCoderUIUtility,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #'instance creation' }
GtPharoCoderUIUtility class >> newExamplesButtonForMethodsCoder: aMethodsCoder [

	^ BrButton new
		  addAptitude: (GtPharoExampleAptitude new coder: aMethodsCoder);
		  addAptitude: BrGlamorousButtonWithIconAptitude
			  - BrGlamorousButtonWithLabelTooltipAptitude;
		  addAptitude:
			  (GtFilterRunExampleButtonTooltipAptitude new coder: aMethodsCoder);
		  addAptitude: (GtPharoStateTooltipAptitude new
				   coder: aMethodsCoder;
				   statesProvider: GtPharoExampleStateProvider new);
		  icon: BrGlamorousVectorIcons play;
		  label: 'Run Examples';
		  action: [ :element | 
		  aMethodsCoder exampler runExamplesFrom: element ]
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
	| aMethodsCoder aMethodsCoderViewModel aTestSuiteViewModel |
	
	aMethodsCoder := GtPharoStreamingBehaviorMethodsCoder forFilter: aGtSearchFilter.
	aMethodsCoderViewModel := GtPharoStreamingMethodsCoderViewModel new streamingCodersModel: aMethodsCoder.

	aTestSuiteViewModel := GtPharoTestSuiteViewModel new pharoTestSuite: (GtPharoTestSuite forStream: aMethodsCoder itemsStream).

	^ aView explicit
		  title: 'Tests';
		  stencil: [ GtPharoStreamingMethodsCoderElement new streamingCodersViewModel: aMethodsCoderViewModel ];
		  actionStencil: [ 
			  GtPharoCoderUIUtility
				  newTestsDropdownButtonForViewModel: aTestSuiteViewModel ]
]
