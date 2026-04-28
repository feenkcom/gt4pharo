Class {
	#name : #GtPharoRenameSelectorPartElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'selectorModel',
		'selectorPartModel',
		'editorElement'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #initialization }
GtPharoRenameSelectorPartElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #'gt - extensions' }
GtPharoRenameSelectorPartElement >> gtActionInspectSelectorModelFor: anAction [
	<gtAction>
	selectorModel ifNil: [ ^ anAction noAction ].

	^ anAction button
		priority: 90;
		target: GtPhlowObjectContextMenuTarget;
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Inspect selector model';
		id: GtInspectorInspectButtonId;
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		menuItemPreview: [ selectorModel gtDisplayText ];
		action: [ :aButton | aButton phlow spawnObject: selectorModel ];
		primaryModifierAction: [ :aButton | 
				BlSpace new
					withCommonSettings;
					objectInPager: selectorModel;
					showFrom: aButton ]
			mouseCursor: BlCopyCursor new
]

{ #category : #'gt - extensions' }
GtPharoRenameSelectorPartElement >> gtActionInspectSelectorPartModelFor: anAction [
	<gtAction>
	selectorPartModel ifNil: [ ^ anAction noAction ].

	^ anAction button
		priority: 91;
		target: GtPhlowObjectContextMenuTarget;
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Inspect selector part model';
		id: GtInspectorInspectButtonId;
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		menuItemPreview: [ selectorPartModel gtDisplayText ];
		action: [ :aButton | aButton phlow spawnObject: selectorPartModel ];
		primaryModifierAction: [ :aButton | 
				BlSpace new
					withCommonSettings;
					objectInPager: selectorPartModel;
					showFrom: aButton ]
			mouseCursor: BlCopyCursor new
]

{ #category : #initialization }
GtPharoRenameSelectorPartElement >> initialize [
	super initialize.

	self initializeEditorElement.

	self addChild: editorElement as: #editorElement.

	self fitContent
]

{ #category : #initialization }
GtPharoRenameSelectorPartElement >> initializeEditorElement [
	editorElement := BrEditableLabel new
			fitContent;
			aptitude: (BrGlamorousEditableLabelAptitude new
					defaultBackground: Color transparent;
					defaultBorder: (BlBorder paint: BrGlamorousColors editorBorderColor);
					minWidth: 5);
			padding: (BlInsets left: 2 right: 2).

	editorElement editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | self onBrTextEditorModifiedEvent: anEvent ].
	self initializeEditorElementShortcuts.
	self initializeEditorElementStyling.
]

{ #category : #initialization }
GtPharoRenameSelectorPartElement >> initializeEditorElementShortcuts [
	editorElement
		whenKey: BlKeyCombination escape
			editorDo: [ :aShortcutEvent | self onEscapeShortcut: aShortcutEvent ];
		whenKey: BlKeyCombination enter
			editorDo: [ :aShortcutEvent | self onEnterShortcut: aShortcutEvent ];
		whenKey: BlKeyCombination tab
			editorDo: [ :aShortcutEvent | self onTabShortcut: aShortcutEvent ];
		whenKey: BlKeyCombination builder shift tab build
			editorDo: [ :aShortcutEvent | self onShiftTabShortcut: aShortcutEvent ];
		whenKey: BlKeyCombination arrowRight
			editorDo: [ :aShortcutEvent | self onArrowRightShortcut: aShortcutEvent ];
		whenKey: BlKeyCombination arrowLeft
			editorDo: [ :aShortcutEvent | self onArrowLeftShortcut: aShortcutEvent ];
		whenKey: BlKeyCombination arrowDown
			editorDo: [ :aShortcutEvent | self onArrowDownShortcut: aShortcutEvent ];
		whenKey: BlKeyCombination arrowUp
			editorDo: [ :aShortcutEvent | self onArrowUpShortcut: aShortcutEvent ]
]

{ #category : #initialization }
GtPharoRenameSelectorPartElement >> initializeEditorElementStyling [
	editorElement
		addAptitude: (BrLazyStyleCommonAptitude new
				focused: [ :aStyle | aStyle do: [ :aWidget | aWidget switchToEditor ] ];
				unfocused: [ :aStyle | aStyle do: [ :aWidget | aWidget switchToLabel ] ];
				when: GtPharoRenameSelectorHiglightState uniqueInstance
					style: [ :aStyle :aTheme | 
						aStyle
							do: [ :aWidget | 
								aWidget
									border: (BlBorder paint: GtSmalltalkSourceCoder nodeHighlightColor width: 1) ]
							after: [ :aWidget | aWidget border: BlBorder empty ] ])
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorPartElement >> onArrowDownShortcut: aShortcutEvent [
	self onArrowRightShortcut: aShortcutEvent
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorPartElement >> onArrowLeftShortcut: aShortcutEvent [
	| cursors |
	aShortcutEvent consumed: true.
	cursors := editorElement cursors positions.
	(cursors includes: 0)
		ifTrue: [ selectorModel focusPreviousSelectorPart: selectorPartModel originalIndex ]
		ifFalse: [ cursors notEmpty
				ifTrue: [ editorElement editor selectNone.
					editorElement editor moveCursorTo: cursors first - 1 ] ]
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorPartElement >> onArrowRightShortcut: aShortcutEvent [
	| cursors |
	aShortcutEvent consumed: true.
	cursors := editorElement cursors positions.
	(cursors includes: editorElement text size)
		ifTrue: [ selectorModel focusNextSelectorPart: selectorPartModel originalIndex ]
		ifFalse: [ cursors notEmpty
				ifTrue: [ editorElement editor selectNone.
					editorElement editor moveCursorTo: cursors first + 1 ] ]
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorPartElement >> onArrowUpShortcut: aShortcutEvent [
	self onArrowLeftShortcut: aShortcutEvent
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorPartElement >> onBrTextEditorModifiedEvent: anEvent [
	selectorPartModel ifNil: [ ^ self ].

	selectorPartModel updateCurrentName: anEvent text asString source: self
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorPartElement >> onEnterShortcut: aShortcutEvent [
	aShortcutEvent consumed: true.
	selectorModel
		displayRefactoringsPreviewOrFocusNextSelectorPart: selectorPartModel originalIndex
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorPartElement >> onEscapeShortcut: aShortcutEvent [
	aShortcutEvent consumed: true.
	
	selectorModel requestCancelRenameSelector
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorPartElement >> onRenameSelectorPartFocusRequested: anAnnouncement [
	anAnnouncement selectorPartModel = selectorPartModel ifFalse: [ ^ self ].

	BlTaskAction
		enqueueElement: editorElement
		action: [ editorElement requestFocus ]
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorPartElement >> onRenameSelectorPartHighlightChangeRequested: anAnnouncement [
	anAnnouncement selectorPartModel = selectorPartModel ifFalse: [ ^ self ].

	BlTaskAction
		enqueueElement: editorElement
		action: [ self updateLabelElementHighlight: anAnnouncement isHighlighted ]
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorPartElement >> onRenameSelectorPartNameChanged: anAnnouncement [
	anAnnouncement selectorPartModel = selectorPartModel ifFalse: [ ^ self ].

	BlTaskAction
		enqueueElement: editorElement
		action: [ editorElement text: anAnnouncement currentName ]
]

{ #category : #'private - hooks' }
GtPharoRenameSelectorPartElement >> onSelectorModelsChanged [
	self updateElement
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorPartElement >> onShiftTabShortcut: aShortcutEvent [
	aShortcutEvent consumed: true.
	selectorModel focusPreviousSelectorPart: selectorPartModel originalIndex
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorPartElement >> onTabShortcut: aShortcutEvent [
	aShortcutEvent consumed: true.
	selectorModel focusNextSelectorPart: selectorPartModel originalIndex
]

{ #category : #'api - initialization' }
GtPharoRenameSelectorPartElement >> selectorModel: aSelectorModel selectorPartModel: aSelectorPartModel [
	"Let's assume models are assigned only once. 
	If it change, we change this part."

	self assert: [ aSelectorModel isNotNil ].
	self assert: [ aSelectorPartModel isNotNil ].
	self assert: [ selectorModel isNil ].
	self assert: [ selectorPartModel isNil ].

	selectorModel := aSelectorModel.
	selectorPartModel := aSelectorPartModel.

	self onSelectorModelsChanged.
	self subscribeToSelectorModels
]

{ #category : #'private - hooks' }
GtPharoRenameSelectorPartElement >> subscribeToSelectorModels [
	selectorPartModel announcer weak
		when: GtPharoRenameSelectorPartNameChanged
			send: #onRenameSelectorPartNameChanged:
			to: self;
		when: GtPharoRenameSelectorPartFocusRequested
			send: #onRenameSelectorPartFocusRequested:
			to: self;
		when: GtPharoRenameSelectorPartHighlightChangeRequested
			send: #onRenameSelectorPartHighlightChangeRequested:
			to: self
]

{ #category : #'private - updating' }
GtPharoRenameSelectorPartElement >> updateEditorElementFilter [
	selectorPartModel filter ifNotNil: [ :aFilter | editorElement inputFilter: aFilter ]
]

{ #category : #'private - updating' }
GtPharoRenameSelectorPartElement >> updateEditorElementStyler [
	selectorPartModel styler ifNotNil: [ :aStyler | editorElement styler: aStyler ]
]

{ #category : #'private - updating' }
GtPharoRenameSelectorPartElement >> updateEditorElementText [
	editorElement text: selectorPartModel currentName
]

{ #category : #'private - updating' }
GtPharoRenameSelectorPartElement >> updateElement [
	self updateEditorElementText.
	self updateEditorElementStyler.
	self updateEditorElementFilter.
]

{ #category : #'private - updating' }
GtPharoRenameSelectorPartElement >> updateLabelElementHighlight: aBoolean [
	aBoolean
		ifTrue: [ editorElement states
				addState: GtPharoRenameSelectorHiglightState uniqueInstance ]
		ifFalse: [ editorElement states
				removeState: GtPharoRenameSelectorHiglightState uniqueInstance ]
]
