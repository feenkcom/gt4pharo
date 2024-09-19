Class {
	#name : #GtPharoProtocol,
	#superclass : #Object,
	#instVars : [
		'protocolClass',
		'protocol'
	],
	#category : #'GToolkit-Pharo-Metamodels-Meta'
}

{ #category : #'as yet unclassified' }
GtPharoProtocol class >> protocol: aProtocol class: aClass [
	^ self new
		protocol: aProtocol;
		protocolClass: aClass
]

{ #category : #'as yet unclassified' }
GtPharoProtocol >> methodSelectors [
	^ protocol methodSelectors
]

{ #category : #'as yet unclassified' }
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
	^ protocolClass
]

{ #category : #accessing }
GtPharoProtocol >> protocolClass: anObject [
	protocolClass := anObject
]
