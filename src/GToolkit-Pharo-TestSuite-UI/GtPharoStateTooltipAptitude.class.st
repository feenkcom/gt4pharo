Class {
	#name : #GtPharoStateTooltipAptitude,
	#superclass : #GtPharoMethodsCoderAptitude,
	#instVars : [
		'statesProvider'
	],
	#category : #'GToolkit-Pharo-TestSuite-UI-Aptitudes'
}

{ #category : #initialization }
GtPharoStateTooltipAptitude >> allStates [

	self statesProviderDo: [ :aProvider | ^ aProvider allStates ].
	^ #(  )
]

{ #category : #initialization }
GtPharoStateTooltipAptitude >> initialize [

	super initialize.

	self add:
		(BrGlamorousWithTooltipAptitude content: [ self newTooltipContent ])
]

{ #category : #initialization }
GtPharoStateTooltipAptitude >> newTooltipContent [

	| aTooltipContent |
	aTooltipContent := BrColumnedList new.
	aTooltipContent
		items: self allStates;
		padding: (BlInsets all: 10);
		fitContent.

	aTooltipContent
		addEventHandlerOn: BrSelectionChanged
		do: [ :anEvent | 
			anEvent selectedDo: [ :theIndices | 
				| aWidgetElement aSelectedObject |
				aWidgetElement := anEvent currentTarget.
				aSelectedObject := aWidgetElement viewModel itemAt:
					                   theIndices first.
				self updateCoderFilterWith: aSelectedObject ] ].

	aTooltipContent column
		title: 'Icon';
		cellStencil: [ 
			GtPharoTestCaseUtility newColoredIcon: BlBackground transparent ];
		dataBinder: [ :anElement :anItem | 
			anElement background: anItem color ];
		width: 10.

	aTooltipContent column
		title: 'Name';
		cellStencil: [ BrLabel new aptitude: BrGlamorousLabelAptitude ];
		dataBinder: [ :anElement :anItem | anElement text: anItem label ];
		width: 100.

	aTooltipContent column
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
	^ aTooltipContent
]

{ #category : #accessing }
GtPharoStateTooltipAptitude >> statesProvider [

	^ statesProvider
]

{ #category : #accessing }
GtPharoStateTooltipAptitude >> statesProvider: aProvider [

	statesProvider := aProvider
]

{ #category : #accessing }
GtPharoStateTooltipAptitude >> statesProviderDo: aBlock [

	self statesProvider ifNotNil: aBlock
]

{ #category : #'private - updating' }
GtPharoStateTooltipAptitude >> totalStringForState: aState [

	self coderDo: [ :aCoder | 
		self statesProviderDo: [ :aProvider | 
			^ aProvider totalDescriptionForState: aState in: aCoder ] ].
	^ '?'
]

{ #category : #initialization }
GtPharoStateTooltipAptitude >> updateCoderFilterWith: aSelectedObject [

	^ self coderDo: [ :aCoder | 
		  self statesProviderDo: [ :aProvider | 
			  aProvider
				  updateCoder: aCoder
				  filterWith: aSelectedObject
				  source: self ] ]
]
