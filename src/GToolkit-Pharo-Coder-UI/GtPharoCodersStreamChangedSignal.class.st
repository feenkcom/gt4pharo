Class {
	#name : #GtPharoCodersStreamChangedSignal,
	#superclass : #GtPharoExampleSuiteMediatorSignal,
	#instVars : [
		'announcement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtPharoCodersStreamChangedSignal >> announcement [

	^ announcement
]

{ #category : #accessing }
GtPharoCodersStreamChangedSignal >> announcement: anObject [

	announcement := anObject
]

{ #category : #printing }
GtPharoCodersStreamChangedSignal >> printOneLineContentsOn: aStream [
	self printOneLineCommunicatorId: aStream
]
