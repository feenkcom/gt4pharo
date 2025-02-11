Class {
	#name : #GtPharoHidingStyler,
	#superclass : #GtGenericPharoStyler,
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
	folders := OrderedCollection new.
	aText
		findAttributesSuchThat: [ :att | att class == GtTextFolderAttribute ]
		indicesDo: [ :_start :_end :att | folders add: att ].

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
GtPharoHidingStyler >> foldRanges: aCollectionOfRanges withHoverText: aString [
	| folder messageMarker |
	((text attributesAt: aCollectionOfRanges first first - 1)
		anySatisfy: [ :each | each class == GtTextFolderAttribute ])
		ifTrue: [ ^ self ].
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
	self
		attribute: folder
		from: aCollectionOfRanges first first - 1
		to: aCollectionOfRanges first first - 1.
	InitiallyFolded
		ifTrue: [ folder isExpanded: false.
			folder applyExpandedOrCollapsedAttributesOnText: text ]
]

{ #category : #'as yet unclassified' }
GtPharoHidingStyler >> styleAssert: aMessage [
	self
		foldRanges: {aMessage startPosition to: aMessage stopPosition}
		withHoverText: 'Assert'
]

{ #category : #'as yet unclassified' }
GtPharoHidingStyler >> styleBeaconSignal: aMessage [
	self
		foldRanges: {aMessage startPosition to: aMessage stopPosition}
		withHoverText: 'Beacon'
]

{ #category : #'as yet unclassified' }
GtPharoHidingStyler >> styleTimeDuring: aMessage [
	self
		foldRanges: {aMessage startPosition to: aMessage message values second leftBracket position.
				aMessage message values second rightBracket position
					to: aMessage message values second rightBracket position}
		withHoverText: 'Telemetry'
]

{ #category : #'as yet unclassified' }
GtPharoHidingStyler >> visitCascade: aCascade [
	super visitCascade: aCascade.
	aCascade messages last selector == #emit ifFalse: [ ^ self ].
	self
		foldRanges: {aCascade startPosition to: aCascade stopPosition}
		withHoverText: 'Beacon'
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
