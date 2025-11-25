Class {
	#name : #GtPharoSuiteOverviewContentElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtWithPharoSuiteViewModel',
	#classTraits : 'TGtWithPharoSuiteViewModel classTrait',
	#instVars : [
		'listElement',
		'stateElements',
		'toolbarElement',
		'localToggle',
		'remoteToggle',
		'playButton',
		'errorElement',
		'updater'
	],
	#category : 'GToolkit-Pharo-TestSuite-UI-! Views'
}

{ #category : #initialization }
GtPharoSuiteOverviewContentElement >> initialize [
	super initialize.

	updater := BrElementUpdater new element: self selector: #updateElement.

	self
		vFitContent;
		hMatchParent.

	listElement := self newStatesList.
	stateElements := Dictionary new.

	self initializeToolbar.
	self initializeErrorElement.

	self addChild: listElement as: #list.
	self addChild: toolbarElement as: #toolbar.
	self addChild: errorElement.
	self
		addAptitude: (BrLayoutResizerAptitude new vAnyToFitContent: toolbarElement)
]

{ #category : #initialization }
GtPharoSuiteOverviewContentElement >> initializeErrorElement [
	errorElement := BrButton new
			id: GtPharoSuiteExecutionErrorButtonId;
			beSmallSize;
			vFitContent;
			hMatchParent;
			aptitude: (BrGlamorousButtonExteriorAptitude new
					backgroundPaint: BrGlamorousColors paleErrorBackgroundColor)
					+ BrGlamorousButtonRectangularAptitude + BrGlamorousButtonIconAptitude
					+ BrGlamorousButtonLabelAptitude;
			margin: (BlInsets top: 10);
			visibility: BlVisibility gone;
			icon: BrGlamorousVectorIcons inspect;
			label: 'Execution error';
			action: [ :aButton | self spawnErrorDetailFrom: aButton ]
]

{ #category : #initialization }
GtPharoSuiteOverviewContentElement >> initializeToolbar [
	toolbarElement := BrToolbar new.
	toolbarElement aptitude: (BrGlamorousToolbarAptitude new spacing: 0).
	toolbarElement
		hMatchParent;
		vFitContent.

	toolbarElement
		addItem: (BrToggleGroup new
				aptitude: BrGlamorousToggleGroupAptitude new;
				addToggle: (localToggle := BrToggle new
							id: GtPharoSuiteLocalToggleId;
							activate;
							disable;
							beSmallSize;
							aptitude: BrGlamorousToggleWithCheckedIconAndLabelAptitude;
							label: 'Local';
							icon: BrGlamorousVectorIcons accept;
							when: BrToggleActivatedEvent
								do: [ :anEvent | self onLocalActivated: anEvent ]);
				addToggle: (remoteToggle := BrToggle new
							id: GtPharoSuiteRemoteToggleId;
							disable;
							beSmallSize;
							aptitude: BrGlamorousToggleWithCheckedIconAndLabelAptitude;
							label: 'Remote';
							icon: BrGlamorousVectorIcons accept;
							when: BrToggleActivatedEvent
								do: [ :anEvent | self onRemoteActivated: anEvent ])).

	toolbarElement
		addItem: (BlElement new
				viewModel: BrWidgetModel new;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical exact: 0 ]).

	toolbarElement addItem: (playButton := self newPlayButton)
]

{ #category : #'private - instance creation' }
GtPharoSuiteOverviewContentElement >> newPlayButton [
	^ BrButton new
		id: GtPharoSuitePlayButtonId;
		disable;
		beSmallSize;
		aptitude: BrGlamorousButtonWithIconAndLabelAptitude new;
		icon: BrGlamorousVectorIcons play;
		label: 'Run';
		action: [ :aButton | self playFrom: aButton ];
		addAptitude: (GtPhlowBrowseDefinitionAptitude new definition: [ self suiteViewModel ]);
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				whenPending: [ :aButton | 
					aButton
						disable;
						label: 'Running...' ];
				whenSuccess: [ :aButton | 
					aButton
						enable;
						label: 'Run' ] ]
]

{ #category : #'private - instance creation' }
GtPharoSuiteOverviewContentElement >> newStateElement [
	^ GtPharoSuiteOverviewStateElement new
		when: BlClickEvent do: [ :anEvent |
			anEvent consumed: true.
			self suiteViewModel selectedState: anEvent currentTarget state ]
]

{ #category : #'private - instance creation' }
GtPharoSuiteOverviewContentElement >> newStateElementsCachingAs: aDictionary [
	^ suiteViewModel allStates collect: [ :eachState |
		aDictionary at: eachState put: self newStateElement ]
]

{ #category : #'private - instance creation' }
GtPharoSuiteOverviewContentElement >> newStatesList [
	^ BrVerticalPane new
		hMatchParent;
		vFitContent
]

{ #category : #'private - event handling' }
GtPharoSuiteOverviewContentElement >> onLocalActivated: anEvent [

	self suiteViewModel beLocalFrom: self
]

{ #category : #'private - event handling' }
GtPharoSuiteOverviewContentElement >> onRemoteActivated: anEvent [

	self suiteViewModel beRemoteFrom: self
]

{ #category : #'private - announcement handling' }
GtPharoSuiteOverviewContentElement >> onSuiteStreamChanged: anAnnouncement [
	updater requestUpdate
]

{ #category : #'api - suite view model' }
GtPharoSuiteOverviewContentElement >> onSuiteViewModelChanged [

	self updateElement
]

{ #category : #'private - event handling' }
GtPharoSuiteOverviewContentElement >> playFrom: aButton [

	self asyncSink cleanSink.
	self parent
		stream: (self suiteViewModel playFrom: aButton)
		sink: self asyncSink
]

{ #category : #'private - event handling' }
GtPharoSuiteOverviewContentElement >> spawnErrorDetailFrom: aButton [

	self suiteViewModel hasExecutionError ifFalse: [ ^ self ].

	aButton phlow spawnObject: self suiteViewModel executionDetail
]

{ #category : #'api - suite view model' }
GtPharoSuiteOverviewContentElement >> subscribeToSuiteViewModel [
	self suiteViewModel
		when: GtPharoSuiteStreamChanged
		send: #onSuiteStreamChanged:
		to: self
]

{ #category : #'api - suite view model' }
GtPharoSuiteOverviewContentElement >> unsubscribeFromSuiteViewModel [
	self suiteViewModel unsubscribe: self
]

{ #category : #'private - updating' }
GtPharoSuiteOverviewContentElement >> updateElement [
	self updateListElement.
	self updateToggles.
	self updateErrorElement.
	self updateSink
]

{ #category : #'private - updating' }
GtPharoSuiteOverviewContentElement >> updateErrorElement [
	| isVisible |

	isVisible := self suiteViewModel hasExecutionError.

	isVisible
		ifTrue: [ errorElement visibility: BlVisibility visible ]
		ifFalse: [ errorElement visibility: BlVisibility gone ]
]

{ #category : #'private - updating' }
GtPharoSuiteOverviewContentElement >> updateListElement [
	listElement
		removeChildren;
		addChildren: (self newStateElementsCachingAs: stateElements).

	suiteViewModel allStates do: [ :eachState | self updateStateElementFor: eachState ]
]

{ #category : #'private - updating' }
GtPharoSuiteOverviewContentElement >> updateSink [
	| aGroupBySink |

	aGroupBySink := AsyncGroupBySink new
		groupBy: [ :eachTestCase | suiteViewModel suiteCaseStateOf: eachTestCase ].

	suiteViewModel allStates do: [ :eachState |
		aGroupBySink at: eachState putSink: (stateElements at: eachState) asyncSink ].

	self asyncSink sink: (AsyncFanoutSink
		forSinkA: (stateElements at: suiteViewModel allSuiteCasesState) asyncSink
		sinkB: (AsyncFanoutSink
			forSinkA: aGroupBySink
			sinkB: playButton asyncSink))
]

{ #category : #'private - updating' }
GtPharoSuiteOverviewContentElement >> updateStateElementFor: aState [
	| aStateElement |
	aStateElement := stateElements at: aState.
	aStateElement state: aState.
	aStateElement id: (GtPharoSuiteStateId new state: aState)
]

{ #category : #'private - updating' }
GtPharoSuiteOverviewContentElement >> updateToggles [
	| hasPendingExecution |

	hasPendingExecution := self suiteViewModel hasPendingExecution.

	localToggle enabled: hasPendingExecution not.
	remoteToggle enabled: hasPendingExecution not.

	self suiteViewModel isLocal
		ifTrue: [ localToggle activate ]
		ifFalse: [ remoteToggle activate ]
]
