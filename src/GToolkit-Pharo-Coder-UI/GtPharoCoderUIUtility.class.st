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
