Class {
	#name : #GtPharoRenameSelectorSwapButtonElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TBrSizeAdjustable',
	#classTraits : 'TBrLayoutResizable classTrait + TBrSizeAdjustable classTrait',
	#instVars : [
		'selectorModel',
		'buttonElement',
		'icon',
		'tooltip',
		'actionBlock',
		'id',
		'hoveredBlock',
		'unhoveredBlock',
		'correspondingModels'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorSwapButtonElement >> action: aBlock [
	buttonElement action: aBlock
]

{ #category : #'api - size adjustable' }
GtPharoRenameSelectorSwapButtonElement >> beSize: aBrSizeAdjustmentState [
	buttonElement beSize: aBrSizeAdjustmentState
]

{ #category : #initialization }
GtPharoRenameSelectorSwapButtonElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #'gt-actions' }
GtPharoRenameSelectorSwapButtonElement >> gtActionInspectSelectorModelFor: anAction [
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
				showFrom: aButton ];
		mouseCursor: BlCopyCursor new
]

{ #category : #visibility }
GtPharoRenameSelectorSwapButtonElement >> hide [
	^ self visibility: BlVisibility hidden
]

{ #category : #accessing }
GtPharoRenameSelectorSwapButtonElement >> hovered: aHoveredBlock after: anAfterBlock [
	hoveredBlock := aHoveredBlock.
	unhoveredBlock := anAfterBlock
]

{ #category : #accessing }
GtPharoRenameSelectorSwapButtonElement >> icon: anIcon [
	buttonElement icon: anIcon
]

{ #category : #initialization }
GtPharoRenameSelectorSwapButtonElement >> initialize [
	super initialize.

	self initializeButtonElement.

	self addChild: buttonElement as: #buttonElement.
	
	self initializeElementStyling.

	self fitContent.
	self beMiniSize
]

{ #category : #initialization }
GtPharoRenameSelectorSwapButtonElement >> initializeButtonElement [
	buttonElement := BrButton new.
	buttonElement
		aptitude: BrGlamorousButtonExteriorAptitude
				+ ((BrGlamorousButtonRectangularAptitude paddingScale: 2 / 3)
						+ BrGlamorousButtonIconAptitude
						+ BrGlamorousButtonWithLabelTooltipAptitude2).

	buttonElement margin: (BlInsets left: 1 right: 1).

	buttonElement
		addAptitude: (BrLazyStyleCommonAptitude new
				hovered: [ :aStyle | aStyle do: [ :aWidget | self onHovered ] after: [ :aWidget | self onUnhovered ] ])
]

{ #category : #initialization }
GtPharoRenameSelectorSwapButtonElement >> initializeElementStyling [
	self
		addAptitude: (BrLazyStyleCommonAptitude new
				when: GtPharoRenameSelectorVisibilityState uniqueInstance
				style: [ :aStyle | aStyle do: [ :aWidget | self show ] after: [ :aWidget | self hide ] ])
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorSwapButtonElement >> onHovered [
	hoveredBlock
		ifNotNil: [ :aBlock | aBlock cull: buttonElement cull: selectorModel ]
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorSwapButtonElement >> onRenameSelectorSwapVisibilityChanged: anAnnouncement [
	anAnnouncement selectorModel = selectorModel ifFalse: [ ^ self ].

	(anAnnouncement correspondingModels
		anySatisfy: [ :eachModel | correspondingModels includes: eachModel ])
		ifFalse: [ ^ self ].

	BlTaskAction
		enqueueElement: self
		action: [ self updateVisibility: anAnnouncement isVisible ]
]

{ #category : #'private - hooks' }
GtPharoRenameSelectorSwapButtonElement >> onSelectorModelChanged [
	self updateElement
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorSwapButtonElement >> onUnhovered [
	unhoveredBlock
		ifNotNil: [ :aBlock | aBlock cull: buttonElement cull: selectorModel ]
]

{ #category : #accessing }
GtPharoRenameSelectorSwapButtonElement >> selectorModel: aSelectorModel partAndParameterModels: aCollectionOfModels [
	self assert: [ aSelectorModel isNotNil ].
	self assert: [ selectorModel isNil ].
	self assert: [ aCollectionOfModels isNotNil ].
	self assert: [ correspondingModels isNil ].

	selectorModel := aSelectorModel.
	correspondingModels := aCollectionOfModels.

	self onSelectorModelChanged.
	self subscribeToSelectorModels
]

{ #category : #visibility }
GtPharoRenameSelectorSwapButtonElement >> show [
	^ self visibility: BlVisibility visible
]

{ #category : #'private - hooks' }
GtPharoRenameSelectorSwapButtonElement >> subscribeToSelectorModels [
	selectorModel announcer weak
		when: GtPharoRenameSelectorSwapVisibilityChanged
		send: #onRenameSelectorSwapVisibilityChanged:
		to: self
]

{ #category : #accessing }
GtPharoRenameSelectorSwapButtonElement >> tooltip: aString [
	buttonElement label: aString
]

{ #category : #updating }
GtPharoRenameSelectorSwapButtonElement >> updateElement [
	
]

{ #category : #'private - updating' }
GtPharoRenameSelectorSwapButtonElement >> updateVisibility: aBoolean [
	aBoolean
		ifTrue: [ self states
				addState: GtPharoRenameSelectorVisibilityState uniqueInstance ]
		ifFalse: [ self states
				removeState: GtPharoRenameSelectorVisibilityState uniqueInstance ]
]
