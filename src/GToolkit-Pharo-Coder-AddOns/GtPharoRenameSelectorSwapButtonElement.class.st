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
		'unhoveredBlock'
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

{ #category : #'private - event handling' }
GtPharoRenameSelectorSwapButtonElement >> onHovered [
	hoveredBlock
		ifNotNil: [ :aBlock | aBlock cull: buttonElement cull: selectorModel ]
]

{ #category : #updating }
GtPharoRenameSelectorSwapButtonElement >> onSelectorModelChanged [
	self updateElement
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorSwapButtonElement >> onUnhovered [
	unhoveredBlock
		ifNotNil: [ :aBlock | aBlock cull: buttonElement cull: selectorModel ]
]

{ #category : #accessing }
GtPharoRenameSelectorSwapButtonElement >> selectorModel: aSelectorModel [
	self assert: [ aSelectorModel isNotNil ].
	self assert: [ selectorModel isNil ].

	selectorModel := aSelectorModel.

	self onSelectorModelChanged
]

{ #category : #accessing }
GtPharoRenameSelectorSwapButtonElement >> tooltip: aString [
	buttonElement label: aString
]

{ #category : #updating }
GtPharoRenameSelectorSwapButtonElement >> updateElement [
	
]
