Class {
	#name : #GtPharoExampleSuiteMediatorSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'mediator'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtPharoExampleSuiteMediatorSignal >> id [
	^ self mediator ifNotNil: #identityHash
]

{ #category : #accessing }
GtPharoExampleSuiteMediatorSignal >> mediator [

	^ mediator
]

{ #category : #accessing }
GtPharoExampleSuiteMediatorSignal >> mediator: anObject [

	mediator := anObject
]

{ #category : #accessing }
GtPharoExampleSuiteMediatorSignal >> mediatorLabel [
	^ self mediator ifNil: [ '' ] ifNotNil: [ self mediator mediatorLabel ]
]

{ #category : #printing }
GtPharoExampleSuiteMediatorSignal >> printOneLineCommunicatorId: aStream [
	self mediator ifNil: [ ^ self ].
	aStream
		nextPutAll: self mediatorLabel;
		nextPutAll: '-ID: ';
		print: self id
]
