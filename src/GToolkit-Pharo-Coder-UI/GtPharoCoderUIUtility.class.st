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
