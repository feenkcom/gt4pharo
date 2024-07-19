Class {
	#name : #GtPharoStreamingMethodsScrollToTargetSignal,
	#superclass : #GtPharoStreamingMethodsCoderElementSignal,
	#instVars : [
		'promise',
		'scrollTarget'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Beacon Signals'
}

{ #category : #'gt - extensions' }
GtPharoStreamingMethodsScrollToTargetSignal >> gtPromiseFor: aView [
	<gtView>
	self promise ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Promise';
		priority: 1;
		object: [ self promise ];
		view: #gtPromiseFor:
]

{ #category : #printing }
GtPharoStreamingMethodsScrollToTargetSignal >> printOneLineContentsOn: stream [
	self scrollTarget printTargetNameOn: stream.
	stream space.

	super printOneLineContentsOn: stream
]

{ #category : #accessing }
GtPharoStreamingMethodsScrollToTargetSignal >> promise [
	^ promise
]

{ #category : #accessing }
GtPharoStreamingMethodsScrollToTargetSignal >> promise: anObject [
	promise := anObject
]

{ #category : #accessing }
GtPharoStreamingMethodsScrollToTargetSignal >> scrollTarget [
	^ scrollTarget
]

{ #category : #accessing }
GtPharoStreamingMethodsScrollToTargetSignal >> scrollTarget: anObject [
	scrollTarget := anObject
]
