"
A wrapper around Pharo's {{gtClass:Protocol}}.

"
Class {
	#name : #GtPharoProtocol,
	#superclass : #GtAbstractProtocol,
	#instVars : [
		'protocol',
		'protocolClass',
		'isClassSide'
	],
	#category : #'GToolkit-Pharo-Metamodels-Protocols'
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

{ #category : #accessing }
GtPharoProtocol >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ protocol name = anObject protocol name
		and: [ protocolClass = anObject protocolClass
				and: [ isClassSide = anObject isClassSide ] ]
]

{ #category : #accessing }
GtPharoProtocol >> allMethods [
	| theClass |
	theClass := self protocolClass.
	^ protocol methodSelectors collect: [ :eachSelector |
		theClass >> eachSelector ]
]

{ #category : #testing }
GtPharoProtocol >> canBeRemoved [
	^ protocol canBeRemoved
]

{ #category : #testing }
GtPharoProtocol >> canBeRenamed [
	^ protocol canBeRenamed
]

{ #category : #accessing }
GtPharoProtocol >> classSide [
	| aClassSideProtocol aClass |
	self isClassSide ifTrue: [ ^ self ].

	aClass := self protocolClass classSide.
	aClassSideProtocol := self protocol gtClassSide: aClass.
	
	^ self class
		protocol: aClassSideProtocol
		class: aClass
]

{ #category : #accessing }
GtPharoProtocol >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ (protocol hash bitXor: protocolClass hash) bitXor: isClassSide hash
]

{ #category : #testing }
GtPharoProtocol >> isClassSide [
	^ isClassSide
]

{ #category : #testing }
GtPharoProtocol >> isVirtualProtocol [
	^ self 
		forPharo11AndPharo12: [ 
			"for the moment "
			false ] 
		forPharo10: [ protocol isVirtualProtocol ]
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
	protocolClass := aClass instanceSide
]
