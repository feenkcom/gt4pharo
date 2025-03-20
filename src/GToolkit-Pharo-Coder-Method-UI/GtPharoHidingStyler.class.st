Class {
	#name : #GtPharoHidingStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'oldNodeMap'
	],
	#classVars : [
		'InitiallyFolded'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Stylers'
}

{ #category : #initalization }
GtPharoHidingStyler class >> initialize [
	InitiallyFolded := false
]

{ #category : #accessing }
GtPharoHidingStyler class >> initiallyFolded [
	^ InitiallyFolded
]

{ #category : #accessing }
GtPharoHidingStyler class >> initiallyFolded: aBoolean [
	InitiallyFolded := aBoolean
]

{ #category : #private }
GtPharoHidingStyler >> anyDecorationsInRange: aRange ofText: aText [
	(aText from: aRange first to: aRange last)
		attributesDo: [ :attrs | 
			(attrs
				anySatisfy: [ :each | 
					each class == BlTextHighlightAttribute
						or: [ each class == BlTextDecorationAttribute ] ]) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'api - styling' }
GtPharoHidingStyler >> extraStyle: aText ast: theAst [
	| folders |
	folders := coderViewModel allSavedAttributesForStyler: self.

	folders
		do: [ :each | 
			aText
				findAttribute: each attribute
				indicesDo: [ :start :end | 
					((self anyCursorsInRange: (start to: end))
						or: [ self anyDecorationsInRange: (start to: end) ofText: aText ])
						ifTrue: [ each isExpanded: true.
							each applyExpandedOrCollapsedAttributesOnText: aText ] ] ]
]

{ #category : #private }
GtPharoHidingStyler >> foldRanges: aCollectionOfRanges withHoverText: aString forNode: aNode [
	| folder messageMarker |
	messageMarker := BrTextInvisibleMarkerAttribute new.
	aCollectionOfRanges
		do: [ :foldedRange | 
			self
				attributes: {messageMarker}
				from: foldedRange first
				to: foldedRange last ].
	folder := GtTextFolderAttribute new
			attribute: messageMarker;
			hoverText: aString.
	coderViewModel
		saveAttribute: folder
		forNode: aNode
		andStyler: self.
	self
		attribute: folder
		from: aCollectionOfRanges first first - 1
		to: aCollectionOfRanges first first - 1.
	oldNodeMap
		at: aNode
		ifPresent: [ :oldFolder | 
			folder isExpanded: oldFolder isExpanded.
			folder applyExpandedOrCollapsedAttributesOnText: text ]
		ifAbsent: [ InitiallyFolded
				ifTrue: [ folder isExpanded: false.
					folder applyExpandedOrCollapsedAttributesOnText: text ] ]
]

{ #category : #initalization }
GtPharoHidingStyler >> initialize [
	super initialize.
	oldNodeMap := Dictionary new
]

{ #category : #'api - styling' }
GtPharoHidingStyler >> style: aText ast: theAst [
	oldNodeMap := coderViewModel nodeAttributeMapForStyler: self.
	coderViewModel resetNodeAttributeMapForStyler: self.
	super style: aText ast: theAst
]

{ #category : #private }
GtPharoHidingStyler >> styleAssert: aMessage [
	self
		foldRanges: {aMessage startPosition to: aMessage indexOfTrailingPeriodIfAny}
		withHoverText: 'Assert'
		forNode: aMessage
]

{ #category : #private }
GtPharoHidingStyler >> styleBeaconSignal: aMessage [
	self
		foldRanges: {aMessage startPosition to: aMessage indexOfTrailingPeriodIfAny}
		withHoverText: 'Beacon'
		forNode: aMessage
]

{ #category : #private }
GtPharoHidingStyler >> styleTimeDuring: aMessage [
	self
		foldRanges: {aMessage startPosition
					to: aMessage message values second leftBracket position.
				aMessage message values second rightBracket position
					to: aMessage message values second rightBracket position}
		withHoverText: 'Telemetry'
		forNode: aMessage
]

{ #category : #visiting }
GtPharoHidingStyler >> visitCascade: aCascade [
	super visitCascade: aCascade.
	aCascade messages last selector == #emit ifFalse: [ ^ self ].
	self
		foldRanges: {aCascade startPosition to: aCascade stopPosition}
		withHoverText: 'Beacon'
		forNode: aCascade
]

{ #category : #visiting }
GtPharoHidingStyler >> visitMessageSend: aMessageSend [
	super visitMessageSend: aMessageSend.
	aMessageSend selector == #assert:description:
		ifTrue: [ self styleAssert: aMessageSend ].
	aMessageSend selector == #time:during:
		ifTrue: [ self styleTimeDuring: aMessageSend ].
	aMessageSend selector == #timeSync:during:
		ifTrue: [ self styleTimeDuring: aMessageSend ].
	aMessageSend selector == #emit ifTrue: [ self styleBeaconSignal: aMessageSend ]
]
