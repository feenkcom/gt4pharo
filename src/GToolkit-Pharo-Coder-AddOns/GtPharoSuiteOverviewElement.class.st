Class {
	#name : #GtPharoSuiteOverviewElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TGtPharoWithSuiteViewModel',
	#classTraits : 'TBrLayoutResizable classTrait + TGtPharoWithSuiteViewModel classTrait',
	#instVars : [
		'listElement',
		'toolbarElement',
		'localToggle',
		'remoteToggle',
		'playButton'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #'private - accessing' }
GtPharoSuiteOverviewElement >> allStates [

	self hasSuiteViewModel ifFalse: [ ^ #(  ) ].
	^ self suiteViewModel allStates
]

{ #category : #initialization }
GtPharoSuiteOverviewElement >> defaultLayout [

	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtPharoSuiteOverviewElement >> initialize [

	super initialize.
	self initializeListElement.
	self initializeToolbar.

	self addChild: self listElement as: #list.
	self addChild: self toolbarElement as: #toolbar.
	self addAptitude:
		(BrLayoutResizerAptitude new vAnyToFitContent: self toolbarElement).
	self fitContent
]

{ #category : #initialization }
GtPharoSuiteOverviewElement >> initializeListElement [

	listElement := BrColumnedList new.
	listElement
		padding: (BlInsets all: 10);
		constraintsDo: [ :c | 
			c minWidth: 180. 
			c minHeight: 10. ];
		fitContent.

	listElement
		addEventHandlerOn: BrSelectionChanged
		do: [ :anEvent | 
			anEvent selectedDo: [ :theIndices | 
				| aWidgetElement aSelectedObject |
				aWidgetElement := anEvent currentTarget.
				aSelectedObject := aWidgetElement viewModel itemAt:
					                   theIndices first.
				self updateCoderFilterWith: aSelectedObject ] ].

	listElement column
		title: 'Icon';
		cellStencil: [ 
			GtPharoTestCaseUtility newColoredIcon: BlBackground transparent ];
		dataBinder: [ :anElement :anItem | 
			anElement background: anItem color ];
		width: 10.

	listElement column
		title: 'Name';
		cellStencil: [ BrLabel new aptitude: BrGlamorousLabelAptitude ];
		dataBinder: [ :anElement :anItem | anElement text: anItem label ];
		width: 100.

	listElement column
		title: 'Amount';
		cellStencil: [ 
			BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				fitContent ];
		dataBinder: [ :anElement :anItem | 
			| aTotal aTotalString aTotalText |
			aTotalString := self totalStringForState: anItem.
			aTotalText := aTotalString asRopedText foreground: Color gray.
			anElement text: aTotalText ].
	^ listElement
]

{ #category : #initialization }
GtPharoSuiteOverviewElement >> initializeToolbar [

	toolbarElement := BrToolbar new.
	toolbarElement aptitude: BrGlamorousToolbarAptitude new.
	toolbarElement
		hMatchParent;
		vFitContent.

	toolbarElement addItem: (BrToggleGroup new
			 aptitude: BrGlamorousToggleGroupAptitude new;
			 addToggle: (localToggle := BrToggle new
					                 activate;
					                 disable;
					                 aptitude: BrGlamorousToggleWithLabelAptitude new;
					                 label: 'Local');
			 addToggle: (remoteToggle := BrToggle new
					                  disable;
					                  aptitude:
						                  BrGlamorousToggleWithLabelAptitude new;
					                  label: 'Remote')).

	toolbarElement addItem: (BlElement new
			 viewModel: BrWidgetModel new;
			 constraintsDo: [ :c | 
				 c horizontal matchParent.
				 c vertical exact: 0 ]).

	toolbarElement addItem: (playButton := BrButton new
			               disable;
			               aptitude: BrGlamorousButtonWithIconAptitude new;
			               icon: BrGlamorousVectorIcons play;
			               label: 'Play')
]

{ #category : #'private - accessing' }
GtPharoSuiteOverviewElement >> listElement [

	^ listElement
]

{ #category : #'private - accessing' }
GtPharoSuiteOverviewElement >> localToggle [

	^ localToggle
]

{ #category : #'api - suite view model' }
GtPharoSuiteOverviewElement >> onSuiteViewModelChanged [

	self updateElement
]

{ #category : #'private - accessing' }
GtPharoSuiteOverviewElement >> playButton [

	^ playButton
]

{ #category : #'private - event handling' }
GtPharoSuiteOverviewElement >> playFrom: aButton [

	self suiteViewModel play
]

{ #category : #'private - accessing' }
GtPharoSuiteOverviewElement >> remoteToggle [

	^ remoteToggle
]

{ #category : #'private - accessing' }
GtPharoSuiteOverviewElement >> toolbarElement [

	^ toolbarElement
]

{ #category : #'private - accessing' }
GtPharoSuiteOverviewElement >> totalStringForState: aState [

	^ self suiteViewModel totalStringForState: aState
]

{ #category : #'private - updating' }
GtPharoSuiteOverviewElement >> updateCoderFilterWith: aState [

	self suiteViewModel updateCoderFilterWith: aState source: self
]

{ #category : #'private - updating' }
GtPharoSuiteOverviewElement >> updateElement [

	self updateListElement.
	self updateToggles.
	self updatePlayButton.
]

{ #category : #'private - updating' }
GtPharoSuiteOverviewElement >> updateListElement [

	self listElement items: self allStates
]

{ #category : #'private - updating' }
GtPharoSuiteOverviewElement >> updatePlayButton [

	self playButton enable.
]

{ #category : #'private - updating' }
GtPharoSuiteOverviewElement >> updateToggles [

	self localToggle enable.
	self remoteToggle enable.
]
