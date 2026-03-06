Class {
	#name : #GtUserActivatableChangeWithExpanderElement,
	#superclass : #GtUserActivatableChangeElement,
	#instVars : [
		'expander',
		'header',
		'description',
		'checkbox',
		'noDiffLabel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #'instance creation' }
GtUserActivatableChangeWithExpanderElement >> activatableChange: aGtUserActivatableChange [
	| label |
	activatableChange ifNotNil: [ activatableChange announcer unsubscribe: self ].
	activatableChange := aGtUserActivatableChange.
	activatableChange announcer weak
		when: #enablementChanged
		send: #onEnablementChanged
		to: self.

	activatableChange isEnabled
		ifTrue: [ checkbox check ]
		ifFalse: [ checkbox uncheck ].
	label := activatableChange change displayString.
	activatableChange change changesSize > 1
		ifTrue: [ label := label asRopedText
					, ((' (' , activatableChange change changesSize printString , ' changes)')
							asRopedText foreground: BrGlamorousColors disabledHeaderTextColor) ].
	description text: label.
	noDiffLabel text: label.

	activatableChange hasDiffChange
		ifTrue: [ expander
				content: [ (GtDiffElement onChange: activatableChange change gtDiffChange)
						styler: activatableChange change gtDiffStyler;
						aptitude: GtDiffFlatAptitude;
						vFitContent;
						beSmallSize ].
			expander visibility: BlVisibility visible.
			noDiffLabel visibility: BlVisibility gone ]
		ifFalse: [ expander visibility: BlVisibility gone.
			noDiffLabel visibility: BlVisibility visible ].

	activatableChange isExpanded
		ifTrue: [ expander expand ]
		ifFalse: [ expander collapse ]
]

{ #category : #private }
GtUserActivatableChangeWithExpanderElement >> hideBrowseButton [
	expander isExpanded ifTrue: [ ^ self ].
	self
		childNamed: #browse
		ifFound: [ :button | button visibility: BlVisibility hidden ]
]

{ #category : #initialization }
GtUserActivatableChangeWithExpanderElement >> initialize [
	| pane |
	super initialize.

	noDiffLabel := BrLabel new
			aptitude: BrGlamorousLabelAptitude;
			padding: (BlInsets all: 4);
			hMatchParent;
			vFitContent;
			visibility: BlVisibility gone.

	expander := BrExpander new.
	expander
		aptitude: (GtCoderExpanderAptitude new
				cornerRadius: 3;
				padding: BlInsets empty;
				doNotReplaceHeader)
				+ (BrStyleCommonAptitude new
						expanded: [ :aStyle | 
							aStyle
								margin: (BlInsets
										top: 5
										left: 5
										bottom: 5
										right: 5) ];
						collapsed: [ :aStyle | 
							aStyle
								margin: (BlInsets
										top: 5
										left: 5
										bottom: 0
										right: 5) ]);
		hMatchParent;
		vFitContent;
		whenExpandedDo: [ activatableChange isExpanded: true ];
		whenCollapsedDo: [ activatableChange isExpanded: false ].

	header := BrVerticalPane new
			hMatchParent;
			vFitContent;
			alignCenterLeft.

	header
		when: BlClickEvent
		do: [ :anEvent | 
			expander toggleExpanded.
			expander isExpanded
				ifTrue: [ self showBrowseButton ]
				ifFalse: [ self hideBrowseButton ].
			anEvent consumed: true ].

	description := BrLabel new
			aptitude: BrGlamorousLabelAptitude;
			padding: (BlInsets left: 5 right: 5);
			fitContent;
			id: #'change-description'.


	pane := BrHorizontalPane new.
	pane hMatchParent.
	pane vFitContent.
	pane addChild: description.

	pane
		addChild: (BrButton new
				visibility: BlVisibility hidden;
				beTinySize;
				margin: (BlInsets top: 2);
				aptitude: BrGlamorousButtonWithIconAptitude new;
				icon: BrGlamorousVectorIcons browse;
				id: #browse;
				label: 'Browse';
				padding: (BlInsets left: 5);
				action: [ :aButton | aButton phlow spawnObject: self activatableChange change gtChangedObject ];
				yourself).

	header
		when: BlMouseEnterEvent do: [ :event | self showBrowseButton ];
		when: BlMouseLeaveEvent do: [ :event | self hideBrowseButton ].

	header addChildren: {pane}.

	checkbox := BrCheckbox new
			aptitude: BrGlamorousCheckboxAptitude new;
			margin: (BlInsets top: 6);
			whenCheckedDo: [ activatableChange isEnabled: true ];
			whenUncheckedDo: [ activatableChange isEnabled: false ].	"beSmallSize;"

	expander header: [ header ].

	self
		addChildren: {checkbox.
				expander.
				noDiffLabel}
]

{ #category : #'event handling' }
GtUserActivatableChangeWithExpanderElement >> onEnablementChanged [

	activatableChange isEnabled
		ifTrue: [ checkbox check ]
		ifFalse: [ checkbox uncheck ]
]

{ #category : #private }
GtUserActivatableChangeWithExpanderElement >> showBrowseButton [
	self activatableChange change gtChangedObject ifNil: [ ^ self ].
	self
		childNamed: #browse
		ifFound: [ :button | button visibility: BlVisibility visible ]
]
