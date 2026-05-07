Class {
	#name : #GtPharoClassExpanderWithMarkerAttribute,
	#superclass : #BrGlamorousTriangleExpanderTextAttribute,
	#instVars : [
		'classToExpand',
		'markerAttribute',
		'createdAttributeTags'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Attributes'
}

{ #category : #'initialize-release' }
GtPharoClassExpanderWithMarkerAttribute class >> forClass: aClass [
	^ self new
		forClass: aClass;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect;
		yourself
]

{ #category : #private }
GtPharoClassExpanderWithMarkerAttribute >> applyExpandedOrCollapsedAttributesInTextEditorElement: anEditorElement [
	markerAttribute ifNil: [ ^ self ].

	isExpanded
		ifFalse: [ self createdAttributeTags
				do: [ :eachTag | anEditorElement removeAttributeTagged: eachTag overMarker: markerAttribute ].
			createdAttributeTags := #() ]
		ifTrue: [ self createdAttributes
				ifEmpty: [ createdAttributeTags := self createAttributes
							collect: [ :eachAttribute | anEditorElement addAttribute: eachAttribute overMarker: markerAttribute ] ]
				ifNotEmpty: [ :existingAttributes | 
					self createdAttributeTags
						ifEmpty: [ createdAttributeTags := existingAttributes
									collect: [ :eachAttribute | anEditorElement addAttribute: eachAttribute overMarker: markerAttribute ] ]
						ifNotEmpty: [ "Attributes are already added" ] ] ]
]

{ #category : #private }
GtPharoClassExpanderWithMarkerAttribute >> buildBehaviorCoder [
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
	^ editorElement
]

{ #category : #private }
GtPharoClassExpanderWithMarkerAttribute >> createAttributes [
	createdAttributes := attributesCreatingBlock value asOrderedCollection.
	createdAttributeTags := #().
	^ createdAttributes
]

{ #category : #accessing }
GtPharoClassExpanderWithMarkerAttribute >> createdAttributeTags [
	^ createdAttributeTags ifNil: [ #() ]
]

{ #category : #accessing }
GtPharoClassExpanderWithMarkerAttribute >> createdAttributesInto: aWriteStream [
	"Add existing attributes to a text that is currently styled by stylers.
	At this moment, it is assumend, that attributes are appending and added after the expand attribute."

	createdAttributes
		ifNotNil: [ :aCollection | aWriteStream nextPutAll: aCollection ]
]

{ #category : #accessing }
GtPharoClassExpanderWithMarkerAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
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
GtPharoClassExpanderWithMarkerAttribute >> expandedClass [
	^classToExpand
]

{ #category : #'initialize-release' }
GtPharoClassExpanderWithMarkerAttribute >> forClass: aClass [
	classToExpand := aClass
]

{ #category : #'initialize-release' }
GtPharoClassExpanderWithMarkerAttribute >> initialize [
	super initialize.
	self
		attributesCreatingBlock: [ BrTextAdornmentDynamicAttribute new
				beAppend;
				stencil: [ self buildBehaviorCoder ] ]
]

{ #category : #accessing }
GtPharoClassExpanderWithMarkerAttribute >> markerAttribute [
	^ markerAttribute
]

{ #category : #accessing }
GtPharoClassExpanderWithMarkerAttribute >> markerAttribute: anObject [
	markerAttribute := anObject
]

{ #category : #private }
GtPharoClassExpanderWithMarkerAttribute >> toggleExpandedOrCollapsedAttributesInTextEditorElement: anEditorElement [
	self isExpanded: isExpanded not.
	self applyExpandedOrCollapsedAttributesInTextEditorElement: anEditorElement
]
