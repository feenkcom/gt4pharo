Class {
	#name : #GtPharoBehaviorDefinitionCoderElement,
	#superclass : #BrExpander,
	#instVars : [
		'modificationIndicator',
		'previewButton',
		'behaviorCoderViewModel',
		'cancelButton'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! Views'
}

{ #category : #'private - instance creation' }
GtPharoBehaviorDefinitionCoderElement >> addDefinitionEditorShortcutsTo: aPropertiesElement [
	aPropertiesElement addShortcut: (BlShortcutWithAction new
		combination: BlKeyCombination arrowUp;
		action: [ :anEvent |
			anEvent currentTarget deepestFocusedChild ifNotNil: [ :aFocusedChild |
				BlFocusFinder new
					up;
					root: anEvent currentTarget;
					referenceElement: aFocusedChild;
					nextFocusDo: [ :aNextFocusElement | aNextFocusElement requestFocus ] ] ]).

	aPropertiesElement addShortcut: (BlShortcutWithAction new
		combination: BlKeyCombination arrowDown;
		action: [ :anEvent |
			anEvent currentTarget deepestFocusedChild ifNotNil: [ :aFocusedChild |
				BlFocusFinder new
					down;
					root: anEvent currentTarget;
					referenceElement: aFocusedChild;
					nextFocusDo: [ :aNextFocusElement | aNextFocusElement requestFocus ] ] ]).
]

{ #category : #'private - instance creation' }
GtPharoBehaviorDefinitionCoderElement >> buildDefinitionEditor [
	| theProperties toolbar |
	modificationIndicator visibility: BlVisibility gone.
	theProperties := BlElement new
			layout: (BlGridLayout new columnCount: 2);
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical fitContent ].
	self addDefinitionEditorShortcutsTo: theProperties.
	self editors
		do: [ :eachEditor | 
			eachEditor
				definitionsDo: [ :each | 
					each
						when: GtBehaviorChangeEvent
						do: [ :event | [ self updateModified ] on: Error do: [ :e |  ] ] ].
			theProperties
				addChildren: {self buildSectionLabel: eachEditor title.
						eachEditor
							aptitude: [ self editableLabelLook ];
							margin: self buttonMargin;
							asElement} ].
	previewButton := BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		label: 'Accept Changes';
		icon: BrGlamorousVectorIcons accept;
		beSmallSize;
		constraintsDo: [ :c | c grid horizontal span: 2 ];
			action: [ self coderViewModel acceptChanges ];
			margin: (BlInsets
					top: 5
					right: 5
					bottom: 0
					left: 5);
			visibility: BlVisibility gone.
	cancelButton := BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude;
			label: 'Cancel';
			icon: BrGlamorousVectorIcons cancel;
			beSmallSize;
			constraintsDo: [ :c | c grid horizontal span: 2 ];
			action: [ self coderViewModel discardChanges ];
			margin: (BlInsets
					top: 5
					right: 5
					bottom: 0
					left: 5);
			visibility: BlVisibility gone.
	toolbar := BrToolbar new aptitude: BrGlamorousToolbarAptitude.
	toolbar
		addItems: {previewButton.
				cancelButton}.
	theProperties addChild: toolbar.
	^ theProperties
]

{ #category : #'private - instance creation' }
GtPharoBehaviorDefinitionCoderElement >> buildDefinitionReader [
	| theProperties theReaders |

	theProperties := BlElement new
		layout: (BlGridLayout new columnCount: 2);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].

	theReaders := self readers.
	theReaders := theReaders first: (2 min: theReaders size).
	theReaders do: [ :eachEditor |
		theProperties addChildren: { 
				(self buildSectionLabel: eachEditor title).
				(eachEditor
					aptitude: [ self readonlyLabelLook ];
					margin: self buttonMargin;
					asElement) } ].

	^ theProperties
]

{ #category : #'private - instance creation' }
GtPharoBehaviorDefinitionCoderElement >> buildSectionLabel: aSectionName [
	
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularFontAndSize foreground: Color gray; fontSize: 12);
		text: aSectionName, ':';
		focusability: BlFocusability none;
		margin: (BlInsets top: 5 right: 5 bottom: 0 left: 5);
		constraintsDo: [ :c | c grid horizontal alignLeft ]
]

{ #category : #'private - ui' }
GtPharoBehaviorDefinitionCoderElement >> buttonMargin [
	^ BlInsets top: 3 left: 0 bottom: 3 right: 5
]

{ #category : #accessing }
GtPharoBehaviorDefinitionCoderElement >> coderViewModel [
	^ behaviorCoderViewModel
]

{ #category : #accessing }
GtPharoBehaviorDefinitionCoderElement >> coderViewModel: aGtBehaviorDefinitionCoderViewModel [

	behaviorCoderViewModel := aGtBehaviorDefinitionCoderViewModel.
	behaviorCoderViewModel weak
		when: GtCoderClassChanged
		send: #updateDefinition
		to: self.
	self initializeElements
]

{ #category : #'private - ui' }
GtPharoBehaviorDefinitionCoderElement >> editableLabelLook [
	^ BrGlamorousEditableLabelAptitude new
		glamorousCodeFont;
		defaultForeground: Color black;
		fontSize: 10
]

{ #category : #'private - accessing' }
GtPharoBehaviorDefinitionCoderElement >> editors [
	<return: #Collection of: #GtCodeDefinitionViewer>

	^ behaviorCoderViewModel coder definition editors
]

{ #category : #initialization }
GtPharoBehaviorDefinitionCoderElement >> initialize [
	super initialize.	

	self
		aptitude: GtCoderExpanderAptitude;
		hMatchParent;
		vFitContent.
	modificationIndicator := self newModificationIndicator.
	self addChild: modificationIndicator.
]

{ #category : #'private - ui' }
GtPharoBehaviorDefinitionCoderElement >> initializeElements [
	self header: [ self buildDefinitionReader ].
	self content: [ self buildDefinitionEditor ]
]

{ #category : #accessing }
GtPharoBehaviorDefinitionCoderElement >> newModificationIndicator [
	^ BlElement new
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignLeft.
			c horizontal exact: 5.
			c vertical matchParent.
			c margin: (BlInsets left: 8) ];
		preventMeAndChildrenMouseEvents;
		background: self theme status changesBackgroundColor;
		id: GtTextualCoderModificationIndicatorId;
		visibility: BlVisibility gone;
		withAsyncPromiseDo: [ :anElementPromise |
			anElementPromise
				whenSuccess: [ :anIndicator :isModified |
					anIndicator visibility: (isModified
						ifTrue: [ BlVisibility visible ]
						ifFalse: [ BlVisibility gone ]) ] ]
]

{ #category : #'private - accessing' }
GtPharoBehaviorDefinitionCoderElement >> readers [
	<return: #Collection of: #GtCodeDefinitionViewer>
	
	^ behaviorCoderViewModel coder definition readers
]

{ #category : #'private - ui' }
GtPharoBehaviorDefinitionCoderElement >> readonlyLabelLook [
	^ BrGlamorousEditorAptitude new
		glamorousCodeFont;
		fontSize: 10;
		foreground: Color black;
		add:
			(BrStyleCommonAptitude new
				default: [ :aStyle | 
					aStyle
						geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
						border: BlBorder empty ];
				hovered: [ :aStyle | 
					aStyle
						border: (BlBorder paint: self theme button hoveredBorderColor width: 1) ]);
		yourself
]

{ #category : #accessing }
GtPharoBehaviorDefinitionCoderElement >> updateDefinition [
	self initializeElements
]

{ #category : #'private - instance creation' }
GtPharoBehaviorDefinitionCoderElement >> updateModified [
	| modified visibility |
	
	modified := self coderViewModel coder difference hasDifference.
	modificationIndicator asyncPromise promise: modified.
	visibility := modified
			ifTrue: [ BlVisibility visible ]
			ifFalse: [ BlVisibility gone ].
	previewButton visibility: visibility.
	cancelButton visibility: visibility
]
