Class {
	#name : #GtPharoNewCodersStreamSignal,
	#superclass : #GtPharoExampleSuiteMediatorSignal,
	#instVars : [
		'stream'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #printing }
GtPharoNewCodersStreamSignal >> printOneLineContentsOn: aStream [
	self printOneLineCommunicatorId: aStream
]

{ #category : #accessing }
GtPharoNewCodersStreamSignal >> stream [
	^ stream
]

{ #category : #accessing }
GtPharoNewCodersStreamSignal >> stream: anObject [
	stream := anObject
]
