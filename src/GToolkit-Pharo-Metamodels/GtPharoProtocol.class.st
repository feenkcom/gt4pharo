Class {
	#name : #GtPharoProtocol,
	#superclass : #Object,
	#instVars : [
		'protocolClass',
		'protocol',
		'isClassSide'
	],
	#category : #'GToolkit-Pharo-Metamodels-Meta'
}

{ #category : #'instance creation' }
GtPharoProtocol class >> protocol: aProtocol class: aClass [
	^ self new
		protocol: aProtocol;
		protocolClass: aClass
]

{ #category : #'instance creation' }
GtPharoProtocol class >> protocolNamed: aProtocolName class: aClass [
	| aProtocol |
	
	aProtocol := aClass organization protocolNamed: aProtocolName.
	self
		assert: [ aProtocol isNotNil ]
		description: [ 'Protocol should exist' ].
	
	^ self new
		protocol: aProtocol;
		protocolClass: aClass
]

{ #category : #'as yet unclassified' }
GtPharoProtocol >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ protocol name = anObject protocol name
		and: [ protocolClass = anObject protocolClass
				and: [ isClassSide = anObject isClassSide ] ]
]

{ #category : #'as yet unclassified' }
GtPharoProtocol >> classSide [
	| aClassSideProtocol aClass |
	self isClassSide ifTrue: [ ^ self ].

	aClass := self protocolClass classSide.
	aClassSideProtocol := self protocol gtClassSide: aClass.
	
	^ self class
		protocol: aClassSideProtocol
		class: aClass
]

{ #category : #'as yet unclassified' }
GtPharoProtocol >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ (protocol hash bitXor: protocolClass hash) bitXor: isClassSide hash
]

{ #category : #testing }
GtPharoProtocol >> isClassSide [
	^ isClassSide
]

{ #category : #'as yet unclassified' }
GtPharoProtocol >> isVirtualProtocol [
	^ protocol isVirtualProtocol
]

{ #category : #accessing }
GtPharoProtocol >> methodSelectors [
	^ protocol methodSelectors
]

{ #category : #accessing }
GtPharoProtocol >> name [
	^ protocol name
]

{ #category : #accessing }
GtPharoProtocol >> protocol [
	^ protocol
]

{ #category : #accessing }
GtPharoProtocol >> protocol: anObject [
	protocol := anObject
]

{ #category : #accessing }
GtPharoProtocol >> protocolClass [
	^ self isClassSide
		ifTrue: [ protocolClass classSide ]
		ifFalse: [ protocolClass instanceSide ]
]

{ #category : #accessing }
GtPharoProtocol >> protocolClass: aClass [
	isClassSide := aClass isClassSide.
	protocolClass := aClass instanceSide.
]
