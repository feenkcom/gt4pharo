Class {
	#name : #GtPharoClassExpanderWithMarkerHidingElementAttribute,
	#superclass : #BrGlamorousTriangleExpanderTextAttribute,
	#instVars : [
		'classToExpand',
		'markerAttribute',
		'createdAttributeTags',
		'expanderModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Attributes'
}

{ #category : #'initialize-release' }
GtPharoClassExpanderWithMarkerHidingElementAttribute class >> forClass: aClass [
	^ self new
		forClass: aClass;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect;
		yourself
]

{ #category : #private }
GtPharoClassExpanderWithMarkerHidingElementAttribute >> applyExpandedOrCollapsedAttributesInTextEditorElement: anEditorElement [
	markerAttribute ifNil: [ ^ self ].

	isExpanded
		ifFalse: [ self createdAttributeTags
				ifEmpty: [  "There is nothing created" ]
				ifNotEmpty: [ self notifyExpansionStatus ] ]
		ifTrue: [ self createdAttributes
				ifEmpty: [ createdAttributeTags := self createAttributes
							collect: [ :eachAttribute | anEditorElement addAttribute: eachAttribute overMarker: markerAttribute ] ]
				ifNotEmpty: [ :existingAttributes | 
					self createdAttributeTags
						ifEmpty: [ createdAttributeTags := existingAttributes
									collect: [ :eachAttribute | anEditorElement addAttribute: eachAttribute overMarker: markerAttribute ] ]
						ifNotEmpty: [ self notifyExpansionStatus ] ] ]
]

{ #category : #private }
GtPharoClassExpanderWithMarkerHidingElementAttribute >> buildBehaviorCoder [
	| editorElement |
	editorElement := GtCoderElement forClass: classToExpand.
	editorElement background: Color white.
	editorElement
		aptitude: BrShadowAptitude
				+ (BrGlamorousWithVerticalResizerAptitude new
						beBottom;
						yourself).
	editorElement
		height: 400;
		margin: (BlInsets
				top: 3
				right: 10
				bottom: 10
				left: 10).

	GtPharoTriangleExpanderModelAnnouncementHandler new
		element: editorElement;
		model: expanderModel;
		install.

	^ editorElement
]

{ #category : #private }
GtPharoClassExpanderWithMarkerHidingElementAttribute >> createAttributes [
	createdAttributes := attributesCreatingBlock value asOrderedCollection.
	createdAttributeTags := #().
	^ createdAttributes
]

{ #category : #accessing }
GtPharoClassExpanderWithMarkerHidingElementAttribute >> createdAttributeTags [
	^ createdAttributeTags ifNil: [ #() ]
]

{ #category : #accessing }
GtPharoClassExpanderWithMarkerHidingElementAttribute >> createdAttributesInto: aWriteStream [
	"Add existing attributes to a text that is currently styled by stylers.
	At this moment, it is assumend, that attributes are appending and added after the expand attribute."

	createdAttributes
		ifNotNil: [ :aCollection | aWriteStream nextPutAll: aCollection ]
]

{ #category : #accessing }
GtPharoClassExpanderWithMarkerHidingElementAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| aToggle |
	aToggle := BrInlineExpanderElement new
			id: self id;
			aptitude: BrGlamorousTriangleInCircleExpanderAptitude;
			expanded: self isExpanded;
			padding: (BlInsets all: 2);
			margin: (BlInsets top: 2);
			mouseCursor: BlCursor default;
			toggleAction: [ self toggleExpandedOrCollapsedAttributesInTextEditorElement: anEditorElement ];
			when: BlClickEvent
				do: [ :anEvent | 
					anEvent modifiers isSoftAltOnly
						ifTrue: [ anEvent consumed: true.
							anEvent target phlow
								spawnObject: (self definingMethod ifNil: [ self ] ifNotNil: [ :meth | meth ]) ] ].

	self applyExpandedOrCollapsedAttributesInTextEditorElement: anEditorElement.

	^ aToggle
]

{ #category : #accessing }
GtPharoClassExpanderWithMarkerHidingElementAttribute >> expandedClass [
	^classToExpand
]

{ #category : #'initialize-release' }
GtPharoClassExpanderWithMarkerHidingElementAttribute >> forClass: aClass [
	classToExpand := aClass
]

{ #category : #'initialize-release' }
GtPharoClassExpanderWithMarkerHidingElementAttribute >> initialize [
	super initialize.
	expanderModel := GtPharoTriangleExpanderModel new.
	self
		attributesCreatingBlock: [ BrTextAdornmentDynamicAttribute new
				beAppend;
				stencil: [ self buildBehaviorCoder ] ]
]

{ #category : #accessing }
GtPharoClassExpanderWithMarkerHidingElementAttribute >> isExpanded: aBoolean [
	super isExpanded: aBoolean.
	self notifyExpansionStatus
]

{ #category : #accessing }
GtPharoClassExpanderWithMarkerHidingElementAttribute >> markerAttribute [
	^ markerAttribute
]

{ #category : #accessing }
GtPharoClassExpanderWithMarkerHidingElementAttribute >> markerAttribute: anObject [
	markerAttribute := anObject
]

{ #category : #'private - notifying' }
GtPharoClassExpanderWithMarkerHidingElementAttribute >> notifyExpansionStatus [
	expanderModel announcer
		announce: (GtPharoTriangleExpansionChangedAnnouncement new isExpanded: self isExpanded)
]

{ #category : #private }
GtPharoClassExpanderWithMarkerHidingElementAttribute >> toggleExpandedOrCollapsedAttributesInTextEditorElement: anEditorElement [
	self isExpanded: isExpanded not.
	self applyExpandedOrCollapsedAttributesInTextEditorElement: anEditorElement
]
