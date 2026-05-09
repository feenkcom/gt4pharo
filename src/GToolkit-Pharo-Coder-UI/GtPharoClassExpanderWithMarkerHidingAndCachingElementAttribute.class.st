Class {
	#name : #GtPharoClassExpanderWithMarkerHidingAndCachingElementAttribute,
	#superclass : #BrGlamorousTriangleExpanderTextAttribute,
	#instVars : [
		'classToExpand',
		'markerAttribute',
		'createdAttributeTags',
		'expanderModel',
		'expandedId',
		'expandedElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Attributes'
}

{ #category : #'initialize-release' }
GtPharoClassExpanderWithMarkerHidingAndCachingElementAttribute class >> forClass: aClass [
	^ self new
		forClass: aClass;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect;
		yourself
]

{ #category : #private }
GtPharoClassExpanderWithMarkerHidingAndCachingElementAttribute >> applyExpandedOrCollapsedAttributesInTextEditorElement: anEditorElement [
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
GtPharoClassExpanderWithMarkerHidingAndCachingElementAttribute >> buildBehaviorCoder [
	| editorElement |
	editorElement := GtCoderElement forClass: classToExpand.
	editorElement id: self expandedId.
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
GtPharoClassExpanderWithMarkerHidingAndCachingElementAttribute >> createAttributes [
	createdAttributes := attributesCreatingBlock value asOrderedCollection.
	createdAttributeTags := #().
	^ createdAttributes
]

{ #category : #accessing }
GtPharoClassExpanderWithMarkerHidingAndCachingElementAttribute >> createdAttributeTags [
	^ createdAttributeTags ifNil: [ #() ]
]

{ #category : #accessing }
GtPharoClassExpanderWithMarkerHidingAndCachingElementAttribute >> createdAttributesInto: aWriteStream [
	"Add existing attributes to a text that is currently styled by stylers.
	At this moment, it is assumend, that attributes are appending and added after the expand attribute."

	createdAttributes
		ifNotNil: [ :aCollection | aWriteStream nextPutAll: aCollection ]
]

{ #category : #accessing }
GtPharoClassExpanderWithMarkerHidingAndCachingElementAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
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
GtPharoClassExpanderWithMarkerHidingAndCachingElementAttribute >> expandedClass [
	^classToExpand
]

{ #category : #accessing }
GtPharoClassExpanderWithMarkerHidingAndCachingElementAttribute >> expandedId [
	^ expandedId ifNil: [ expandedId := BlElementId noId ]
]

{ #category : #accessing }
GtPharoClassExpanderWithMarkerHidingAndCachingElementAttribute >> expandedId: anObject [
	expandedId := anObject
]

{ #category : #'initialize-release' }
GtPharoClassExpanderWithMarkerHidingAndCachingElementAttribute >> forClass: aClass [
	classToExpand := aClass
]

{ #category : #'initialize-release' }
GtPharoClassExpanderWithMarkerHidingAndCachingElementAttribute >> initialize [
	super initialize.
	expandedId := BlElementId noId.
	expanderModel := BrTextExpanderModel new.
	expandedElement := ValueHolder new.
	self
		attributesCreatingBlock: [ BrTextAdornmentDynamicAttribute new
				withCache: expandedElement selector: #contents;
				beAppend;
				stencil: [ self buildBehaviorCoder ] ]
]

{ #category : #accessing }
GtPharoClassExpanderWithMarkerHidingAndCachingElementAttribute >> isExpanded: aBoolean [
	super isExpanded: aBoolean.
	self notifyExpansionStatus
]

{ #category : #accessing }
GtPharoClassExpanderWithMarkerHidingAndCachingElementAttribute >> markerAttribute [
	^ markerAttribute
]

{ #category : #accessing }
GtPharoClassExpanderWithMarkerHidingAndCachingElementAttribute >> markerAttribute: anObject [
	markerAttribute := anObject
]

{ #category : #'private - notifying' }
GtPharoClassExpanderWithMarkerHidingAndCachingElementAttribute >> notifyExpansionStatus [
	expanderModel announcer
		announce: (BrTextExpanderModelExpansionChangedAnnouncement new
				expanderModel: expanderModel;
				isExpanded: self isExpanded)
]

{ #category : #private }
GtPharoClassExpanderWithMarkerHidingAndCachingElementAttribute >> toggleExpandedOrCollapsedAttributesInTextEditorElement: anEditorElement [
	self isExpanded: isExpanded not.
	self applyExpandedOrCollapsedAttributesInTextEditorElement: anEditorElement
]
