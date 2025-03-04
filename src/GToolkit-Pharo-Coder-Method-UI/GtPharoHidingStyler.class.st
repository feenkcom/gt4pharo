Class {
	#name : #GtPharoHidingStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'nodeMap',
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

{ #category : #'as yet unclassified' }
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
	folders := nodeMap values.

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

{ #category : #'as yet unclassified' }
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
	nodeMap at: aNode put: folder.
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

{ #category : #'as yet unclassified' }
GtPharoHidingStyler >> initialize [
	super initialize.
	nodeMap := Dictionary new.
	oldNodeMap := Dictionary new
]

{ #category : #'as yet unclassified' }
GtPharoHidingStyler >> style: aText ast: theAst [
	oldNodeMap := nodeMap.
	nodeMap := Dictionary new.
	super style: aText ast: theAst
]

{ #category : #'as yet unclassified' }
GtPharoHidingStyler >> styleAssert: aMessage [
	self
		foldRanges: {aMessage startPosition to: aMessage indexOfTrailingPeriodIfAny}
		withHoverText: 'Assert'
		forNode: aMessage
]

{ #category : #'as yet unclassified' }
GtPharoHidingStyler >> styleBeaconSignal: aMessage [
	self
		foldRanges: {aMessage startPosition to: aMessage indexOfTrailingPeriodIfAny}
		withHoverText: 'Beacon'
		forNode: aMessage
]

{ #category : #'as yet unclassified' }
GtPharoHidingStyler >> styleTimeDuring: aMessage [
	self
		foldRanges: {aMessage startPosition
					to: aMessage message values second leftBracket position.
				aMessage message values second rightBracket position
					to: aMessage message values second rightBracket position}
		withHoverText: 'Telemetry'
		forNode: aMessage
]

{ #category : #'as yet unclassified' }
GtPharoHidingStyler >> visitCascade: aCascade [
	super visitCascade: aCascade.
	aCascade messages last selector == #emit ifFalse: [ ^ self ].
	self
		foldRanges: {aCascade startPosition to: aCascade stopPosition}
		withHoverText: 'Beacon'
		forNode: aCascade
]

{ #category : #'as yet unclassified' }
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
