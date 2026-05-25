Class {
	#name : #GtTextFolderAttributeV2,
	#superclass : #BrTextExpanderTextAttributeV2,
	#instVars : [
		'folderAttributeModel',
		'hideAttribute',
		'tooltipText',
		'markerAttribute',
		'highlightTag'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Stylers'
}

{ #category : #'instance creation' }
GtTextFolderAttributeV2 class >> forAttribute: anAttribute [
	self
		deprecated: 'Please use forMarkerAttribute: instead.'
		transformWith: '`@receiver forAttribute: `@statements1'
				-> '`@receiver forMarkerAttribute: `@statements1'.

	^ self forMarkerAttribute: anAttribute
]

{ #category : #'instance creation' }
GtTextFolderAttributeV2 class >> forMarkerAttribute: anAttribute [
	^self new markerAttribute: anAttribute
]

{ #category : #'api - styling' }
GtTextFolderAttributeV2 >> applyExpandedAttributesOnStyledText: aText [
	"This method can be called only by text stylers to add expanded attributes to a new styled text."
	
	self isExpanded ifFalse: [ ^ self ].
	markerAttribute ifNil: [ ^ self ].
	
	aText
		findAttribute: markerAttribute
		indicesDo: [ :aMarkerStartPosition :aMarkerEndPosition | 
			aText
				attributes: {self expandedAppendingAttribute}
				from: aMarkerStartPosition
				to: aMarkerEndPosition ].
]

{ #category : #'api - styling' }
GtTextFolderAttributeV2 >> applyExpandedOrCollapsedAttributesOnText: aText [
	self
		deprecated: 'Please use applyExpandedAttributesOnStyledText: instead.'
		transformWith: '`@receiver applyExpandedOrCollapsedAttributesOnText: `@statements1'
				-> '`@receiver applyExpandedAttributesOnStyledText: `@statements1'.

	self applyExpandedAttributesOnStyledText: aText
]

{ #category : #'api - styling' }
GtTextFolderAttributeV2 >> applyExpandedOrCollapsedIn: aTextEditor [
	self isExpanded
		ifFalse: [ self collapseAttributeIn: aTextEditor ]
		ifTrue: [ self expandAttributeIn: aTextEditor ]
]

{ #category : #accessing }
GtTextFolderAttributeV2 >> attribute [
	self
		deprecated: 'Please use #markerAttribute instead.'
		transformWith: '`@receiver attribute' -> '`@receiver markerAttribute'.

	^ self markerAttribute
]

{ #category : #accessing }
GtTextFolderAttributeV2 >> attribute: anAttribute [
	self
		deprecated: 'Please use markerAttribute: instead.'
		transformWith: '`@receiver attribute: `@statements1' -> '`@receiver markerAttribute: `@statements1'.

	self markerAttribute: anAttribute
]

{ #category : #'private - event handling' }
GtTextFolderAttributeV2 >> clearHighlightInTextEditor: aTextEditor [
	markerAttribute ifNil: [ ^ self ].
	highlightTag ifNil: [ ^ self ].

	false ifTrue: [ aTextEditor removeHighlightsWithId: #'folder-attribute' ].

	aTextEditor removeAttributeTagged: highlightTag overMarker: markerAttribute
]

{ #category : #private }
GtTextFolderAttributeV2 >> collapseAttributeIn: aTextEditor [
	markerAttribute ifNil: [ ^ self ].

	isExpanded := false.
	aTextEditor
		addAttribute: self expandedAppendingAttribute
		overMarker: markerAttribute
]

{ #category : #accessing }
GtTextFolderAttributeV2 >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| aToggle |
	aToggle := BrInlineExpanderElement new
			id: self id;
			aptitude: (BrLabelExpanderAptitude new text: tooltipText);
			expanded: self isExpanded;
			padding: (BlInsets all: 2);
			margin: (BlInsets top: 2);
			mouseCursor: BlCursor default;
			toggleAction: [ :aWidget |
				self toggleExpandedOrCollapsedIn: anEditorElement ].
	tooltipText
		ifNotNil: [ aToggle
				addAptitude: (BrGlamorousWithExplicitTooltipAptitude text: tooltipText) ].
	aToggle
		when: BlMouseEnterEvent
		do: [ :evt | self highlightFoldableTextInTextEditor: anEditorElement ].
	aToggle
		when: BlMouseLeaveEvent
		do: [ :evt | self clearHighlightInTextEditor: anEditorElement ].
	aToggle
		when: BlClickEvent
		do: [ :anEvent | 
			anEvent modifiers isSoftAltOnly
				ifTrue: [ anEvent consumed: true.
					anEvent target phlow
						spawnObject: (self definingMethod ifNil: [ self ] ifNotNil: [ :meth | meth ]) ] ].

	"folderAttributeModel
		ifNotNil: [ :aModel | 
			GtTextFolderAttributeModelAnnouncementHandler new
				folderAttribute: self;
				folderAttributeModel: aModel;
				element: aToggle;
				editorElement: anEditorElement;
				install ]."

	self applyExpandedOrCollapsedIn: anEditorElement.

	^ aToggle
]

{ #category : #private }
GtTextFolderAttributeV2 >> expandAttributeIn: aTextEditor [
	isExpanded := true.
	aTextEditor removeAdornmentAttribute: self expandedAppendingAttribute
]

{ #category : #private }
GtTextFolderAttributeV2 >> expandedAppendingAttribute [
	^ hideAttribute
]

{ #category : #accessing }
GtTextFolderAttributeV2 >> folderAttributeModel [
	^ folderAttributeModel
]

{ #category : #accessing }
GtTextFolderAttributeV2 >> folderAttributeModel: aModel [
	folderAttributeModel = aModel ifTrue: [ ^ self ].

	folderAttributeModel := aModel.
]

{ #category : #'private - event handling' }
GtTextFolderAttributeV2 >> highlightFoldableTextInTextEditor: aTextEditor [
	markerAttribute ifNil: [ ^ self ].

	self flag: #TODO.
	false
		ifTrue: [ aTextEditor
				addHighlight: (BrTextHighlight
						id: #'folder-attribute'
						color: BrGlamorousColors neutralBackgroundColor)
				overMarker: markerAttribute.
			^ self ].

	highlightTag := aTextEditor
			addAttribute: (BlTextUnderlayAttribute paint: BrGlamorousColors neutralBackgroundColor)
			overMarker: markerAttribute
]

{ #category : #accessing }
GtTextFolderAttributeV2 >> hoverText: aString [
	self
		deprecated: 'Please use tooltipText: instead.'
		transformWith: '`@receiver hoverText: `@statements1'
				-> '`@receiver tooltipText: `@statements1'.
				
	self tooltipText: aString
]

{ #category : #accessing }
GtTextFolderAttributeV2 >> initialize [
	super initialize.
	isExpanded := true.
	hideAttribute := BrTextFoldAttribute new
]

{ #category : #accessing }
GtTextFolderAttributeV2 >> isExpanded: aBoolean [
	self assert: [ aBoolean isBoolean ].
	
	isExpanded := aBoolean
]

{ #category : #accessing }
GtTextFolderAttributeV2 >> markerAttribute [
	^ markerAttribute
]

{ #category : #accessing }
GtTextFolderAttributeV2 >> markerAttribute: aMarkerAttribute [
	markerAttribute := aMarkerAttribute
]

{ #category : #accessing }
GtTextFolderAttributeV2 >> tooltipText [
	^ tooltipText
]

{ #category : #accessing }
GtTextFolderAttributeV2 >> tooltipText: aString [
	tooltipText := aString 
]
