Class {
	#name : #GtPharoHidingStyler,
	#superclass : #GtGenericPharoStyler,
	#category : #'GToolkit-Pharo-Coder-Method-UI-Stylers'
}

{ #category : #'as yet unclassified' }
GtPharoHidingStyler >> styleAssert: aMessage [
	| messageMarker folder |
	((text attributesAt: aMessage startPosition - 1)
		anySatisfy: [ :each | each class == GtTextFolderAttribute ])
		ifTrue: [ ^ self ].
	messageMarker := BrTextInvisibleMarkerAttribute new.
	self
		attributes: {messageMarker}
		from: aMessage startPosition
		to: aMessage stopPosition.
	folder := GtTextFolderAttribute new
			attribute: messageMarker;
			hoverText: 'Assert'.
	self
		attribute: folder
		from: aMessage startPosition - 1
		to: aMessage startPosition - 1
]

{ #category : #'as yet unclassified' }
GtPharoHidingStyler >> styleBeaconSignal: aMessage [
	| messageMarker folder |
	((text attributesAt: aMessage startPosition - 1)
		anySatisfy: [ :each | each class == GtTextFolderAttribute ])
		ifTrue: [ ^ self ].
	messageMarker := BrTextInvisibleMarkerAttribute new.
	self
		attributes: {messageMarker}
		from: aMessage startPosition
		to: aMessage stopPosition.
	folder := GtTextFolderAttribute new
			attribute: messageMarker;
			hoverText: 'Beacon'.
	self
		attribute: folder
		from: aMessage startPosition - 1
		to: aMessage startPosition - 1
]

{ #category : #'as yet unclassified' }
GtPharoHidingStyler >> styleTimeDuring: aMessage [
	| messageMarker folder |
	((text attributesAt: aMessage startPosition - 1)
		anySatisfy: [ :each | each class == GtTextFolderAttribute ])
		ifTrue: [ ^ self ].
	messageMarker := BrTextInvisibleMarkerAttribute new.
	self
		attributes: {messageMarker}
		from: aMessage startPosition
		to: aMessage message values second leftBracket position.
	self
		attributes: {messageMarker}
		from: aMessage message values second rightBracket position
		to: aMessage message values second rightBracket position.
	folder := GtTextFolderAttribute new
			attribute: messageMarker;
			hoverText: 'Telemetry'.
	self
		attribute: folder
		from: aMessage startPosition - 1
		to: aMessage startPosition - 1
]

{ #category : #'as yet unclassified' }
GtPharoHidingStyler >> visitCascade: aCascade [
	| nodeMarker folder |
	super visitCascade: aCascade.
	aCascade messages last selector == #emit ifFalse: [ ^ self ].

	((text attributesAt: aCascade startPosition - 1)
		anySatisfy: [ :each | each class == GtTextFolderAttribute ])
		ifTrue: [ ^ self ].
	nodeMarker := BrTextInvisibleMarkerAttribute new.
	self
		attributes: {nodeMarker}
		from: aCascade startPosition
		to: aCascade stopPosition.
	folder := GtTextFolderAttribute new
			attribute: nodeMarker;
			hoverText: 'Beacon'.
	self
		attribute: folder
		from: aCascade startPosition - 1
		to: aCascade startPosition - 1
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
