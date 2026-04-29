Class {
	#name : #GtPharoRenameSelectorParameterElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TBrSizeAdjustable',
	#classTraits : 'TBrLayoutResizable classTrait + TBrSizeAdjustable classTrait',
	#instVars : [
		'parameterModel',
		'labelElement',
		'selectorModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #'api - size adjustable' }
GtPharoRenameSelectorParameterElement >> beSize: aBrSizeAdjustmentState [
	labelElement beSize: aBrSizeAdjustmentState
]

{ #category : #initialization }
GtPharoRenameSelectorParameterElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #'gt-actions' }
GtPharoRenameSelectorParameterElement >> gtActionInspectParameterModelFor: anAction [
	<gtAction>
	parameterModel ifNil: [ ^ anAction noAction ].

	^ anAction button
		priority: 91;
		target: GtPhlowObjectContextMenuTarget;
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Inspect parameter model';
		id: GtInspectorInspectButtonId;
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		menuItemPreview: [ parameterModel gtDisplayText ];
		action: [ :aButton | aButton phlow spawnObject: parameterModel ];
		primaryModifierAction: [ :aButton | 
				BlSpace new
					withCommonSettings;
					objectInPager: parameterModel;
					showFrom: aButton ]
			mouseCursor: BlCopyCursor new
]

{ #category : #initialization }
GtPharoRenameSelectorParameterElement >> initialize [
	super initialize.

	self initializeLabelElement.

	self addChild: labelElement as: #labelElement.

	self fitContent
]

{ #category : #initialization }
GtPharoRenameSelectorParameterElement >> initializeLabelElement [
	labelElement := BrLabel new
			fitContent;
			aptitude: BrGlamorousLabelAptitude new;
			geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
			padding: (BlInsets left: 2 right: 2);
			addAptitude: (BrLazyStyleCommonAptitude new
					when: BlElementState hovered & BlElementState focused
					style: [ :aStyle | 
						aStyle
							do: [ :aWidget | self onLabelElementHoveredAndFocused ] ];
				when: BlElementState hovered | BlElementState focused
					style: [ :aStyle | 
						aStyle
							do: [ :aWidget | self onLabelElementHoveredOrFocused ]
							after: [ :aWidget | self onLabelElementUnhoveredAndUnfocused ] ];
				when: GtPharoRenameSelectorHighlightState uniqueInstance
					style: [ :aStyle :aTheme | 
						aStyle
							do: [ :aWidget | 
								aWidget
									border: (BlBorder paint: GtSmalltalkSourceCoder nodeHighlightColor width: 1) ]
							after: [ :aWidget | aWidget border: BlBorder empty ] ])
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorParameterElement >> onLabelElementHoveredAndFocused [
	selectorModel ifNil: [ ^ self ].
	parameterModel ifNil: [ ^ self ].

	selectorModel
		show: false
		switchButtonsForSelectorParameter: parameterModel
		source: self
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorParameterElement >> onLabelElementHoveredOrFocused [
	selectorModel ifNil: [ ^ self ].
	parameterModel ifNil: [ ^ self ].

	selectorModel
		show: true
		switchButtonsForSelectorParameter: parameterModel
		source: self
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorParameterElement >> onLabelElementUnhoveredAndUnfocused [
	selectorModel ifNil: [ ^ self ].
	parameterModel ifNil: [ ^ self ].

	selectorModel
		show: false
		switchButtonsForSelectorParameter: parameterModel
		source: self
]

{ #category : #'private - hooks' }
GtPharoRenameSelectorParameterElement >> onParameterModelChanged [
	self updateElement
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorParameterElement >> onRenameSelectorParameterHighlightChangeRequested: anAnnouncement [
	anAnnouncement parameterModel = parameterModel ifFalse: [ ^ self ].

	BlTaskAction
		enqueueElement: labelElement
		action: [ self updateLabelElementHighlight: anAnnouncement isHighlighted ]
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorParameterElement >> onRenameSelectorParameterNameChanged: anAnnouncement [
	anAnnouncement parameterModel = parameterModel ifFalse: [ ^ self ].

	BlTaskAction
		enqueueElement: labelElement
		action: [ labelElement text: anAnnouncement currentName ]
]

{ #category : #accessing }
GtPharoRenameSelectorParameterElement >> selectorModel: aSelectorModel parameterModel: aParameterModel [
	"Let's assume model is assigned only once.
	If it change, we change this part."

	self assert: [ aParameterModel isNotNil ].
	self assert: [ aSelectorModel isNotNil ].
	self assert: [ parameterModel isNil ].
	self assert: [ selectorModel isNil ].

	selectorModel := aSelectorModel.
	parameterModel := aParameterModel.

	self onParameterModelChanged.
	self subscribeToParameterModel
]

{ #category : #'private - hooks' }
GtPharoRenameSelectorParameterElement >> subscribeToParameterModel [
	parameterModel announcer weak
		when: GtPharoRenameSelectorParameterNameChanged
			send: #onRenameSelectorParameterNameChanged:
			to: self;
		when: GtPharoRenameSelectorParameterHighlightChangeRequested
			send: #onRenameSelectorParameterHighlightChangeRequested:
			to: self
]

{ #category : #'private - updating' }
GtPharoRenameSelectorParameterElement >> updateElement [
	self updateLabelElementText
]

{ #category : #'private - updating' }
GtPharoRenameSelectorParameterElement >> updateLabelElementHighlight: aBoolean [
	aBoolean
		ifTrue: [ labelElement states
				addState: GtPharoRenameSelectorHighlightState uniqueInstance ]
		ifFalse: [ labelElement states
				removeState: GtPharoRenameSelectorHighlightState uniqueInstance ]
]

{ #category : #'private - updating' }
GtPharoRenameSelectorParameterElement >> updateLabelElementText [
	labelElement text: parameterModel currentName
]
