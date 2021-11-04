Class {
	#name : #GtPharoCoderUIUtility,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #'instance creation' }
GtPharoCoderUIUtility class >> newBorderlessExamplesButtonForMethodsCoder: aMethodsCoder [ 

	^ BrButton new
		  addAptitude: (GtPharoExampleAptitude new coder: aMethodsCoder);
		  addAptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonExteriorAptitude;
		  icon: BrGlamorousVectorIcons play;
		  label: 'Run Examples'
]

{ #category : #'instance creation' }
GtPharoCoderUIUtility class >> newBorderlessTestSuiteButtonForMethodsCoder: aMethodsCoder [

	^ BrButton new
		  addAptitude: (GtPharoTestSuiteAptitude new coder: aMethodsCoder);
		  addAptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonExteriorAptitude;
		  icon: BrGlamorousVectorIcons play;
		  label: 'Run Test Cases'
]

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
GtPharoCoderUIUtility class >> newExamplesDropdownButtonForViewModel: aViewModel methodsCoder: aMethodsCoder [

	| aButton |
	aButton := self newSimpleExampleButtonForMethodsCoder: aMethodsCoder.
	aButton addAptitude: (BrGlamorousWithDropdownAptitude
			 handle: [ 
			 self newBorderlessExamplesButtonForMethodsCoder: aMethodsCoder ]
			 content: [ 
				 GtPharoSuiteOverviewElement new
					 suiteViewModel: aViewModel;
					 margin: (BlInsets all: 10) ]).

	^ aButton
]

{ #category : #'instance creation' }
GtPharoCoderUIUtility class >> newSimpleExampleButtonForMethodsCoder: aMethodsCoder [

	^ BrButton new
		  addAptitude: (GtPharoExampleAptitude new coder: aMethodsCoder);
		  addAptitude: BrGlamorousButtonWithIconAptitude;
		  icon: BrGlamorousVectorIcons play;
		  label: 'Run Examples' 
]

{ #category : #'instace creation' }
GtPharoCoderUIUtility class >> newSimpleTestSuiteButtonForMethodsCoder: aMethodsCoder [

	^ BrButton new
		  addAptitude: (GtPharoTestSuiteAptitude new coder: aMethodsCoder);
		  addAptitude: BrGlamorousButtonWithIconAptitude;
		  icon: BrGlamorousVectorIcons play;
		  label: 'Run Test Cases'
]

{ #category : #'instance creation' }
GtPharoCoderUIUtility class >> newTestSuiteButtonForMethodsCoder: aMethodsCoder [

	^ BrButton new
		  addAptitude: (GtPharoTestSuiteAptitude new coder: aMethodsCoder);
		  addAptitude: BrGlamorousButtonWithIconAptitude
			  - BrGlamorousButtonWithLabelTooltipAptitude;
		  addAptitude: (GtPharoStateTooltipAptitude new
				   coder: aMethodsCoder;
				   statesProvider: GtPharoTestCaseStateProvider new);
		  icon: BrGlamorousVectorIcons play;
		  label: 'Run Test Cases';
		  action: [ :element | 
		  aMethodsCoder testSuite playSelectedFrom: element ]
]

{ #category : #'instace creation' }
GtPharoCoderUIUtility class >> newTestSuiteDropdownForViewModel: aViewModel methodsCoder: aMethodsCoder [

	| aButton |
	aButton := self newSimpleTestSuiteButtonForMethodsCoder:
		           aMethodsCoder.
	aButton addAptitude: (BrGlamorousWithDropdownAptitude
			 handle: [ 
			 self newBorderlessTestSuiteButtonForMethodsCoder: aMethodsCoder ]
			 content: [ 
				 GtPharoSuiteOverviewElement new
					 suiteViewModel: aViewModel;
					 margin: (BlInsets all: 10) ]).

	^ aButton
]
