Class {
	#name : #GtPharoStreamingMethodsChangedSignal,
	#superclass : #GtPharoStreamingMethodsCoderElementSignal,
	#instVars : [
		'scrollTarget'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Beacon Signals'
}

{ #category : #printing }
GtPharoStreamingMethodsChangedSignal >> printOneLineContentsOn: stream [
	self scrollTarget ifNotNil: [ :aTarget | 
		aTarget printTargetNameOn: stream.
		stream space ].

	super printOneLineContentsOn: stream
]

{ #category : #accessing }
GtPharoStreamingMethodsChangedSignal >> scrollTarget [
	^ scrollTarget
]

{ #category : #accessing }
GtPharoStreamingMethodsChangedSignal >> scrollTarget: anObject [
	scrollTarget := anObject
]
