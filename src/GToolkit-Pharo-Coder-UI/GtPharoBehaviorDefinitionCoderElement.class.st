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
	self coderViewModel coder behavior isObsolete ifTrue: [ ^ BlElement new ].
	^ (self coderViewModel coder behavior isTrait
		ifTrue: [ GtTraitUpdateForm onTrait: self coderViewModel coder behavior ]
		ifFalse: [ GtClassUpdateForm onClass: self coderViewModel coder behavior ])
		onElementCreated: [ :aFrame | 
			(aFrame allChildrenBreadthFirstSelect: [ :aChild | aChild isKindOf: BrTagger ])
				do: [ :aTagger | aTagger parent hMatchParent ] ]
]

{ #category : #'private - instance creation' }
GtPharoBehaviorDefinitionCoderElement >> buildDefinitionReader [
	| theProperties theReaders superclass |

	theProperties := BrHorizontalPane new
		hMatchParent;
		vFitContent.

	theReaders := self readers.
	superclass := theReaders first.
	theProperties
		addChildren: {
			self buildSectionLabel: superclass title.
			superclass
				aptitude: [
					self readonlyLabelLook + (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])];
				margin: self buttonMargin;
				asElement
		}.
	theReaders size > 1
		ifTrue: [ theProperties
				addChildren: {self buildSectionLabel: theReaders second title.
						theReaders second
							aptitude: [ self readonlyLabelLook ];
							margin: self buttonMargin;
							asElement} ].

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

{ #category : #'private - instance creation' }
GtPharoBehaviorDefinitionCoderElement >> contextMenuItemsForSuperclass [
	^ {'Browse references'
			-> [ :aBrEditor | aBrEditor phlow spawnObject: aBrEditor text asString asClass gtReferences ]}
]

{ #category : #'private - ui' }
GtPharoBehaviorDefinitionCoderElement >> editableLabelLook [
	^ BrGlamorousEditableLabelAptitude new
		glamorousCodeFont;
		defaultForeground: Color black;
		fontSize: 10
]

{ #category : #initialization }
GtPharoBehaviorDefinitionCoderElement >> initialize [
	super initialize.	

	self
		aptitude: GtCoderExpanderAptitude;
		hMatchParent;
		vFitContent.
	
	self when: BlClickEvent do: [ :anEvent |
		anEvent consumed: true.
		self expand ].
	
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
	self enqueueTask: (BlTaskAction new action: [ self initializeElements ])
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
