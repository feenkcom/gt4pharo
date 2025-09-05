Class {
	#name : #GtPharoStreamingMethodsCoderElementSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Beacon Signals'
}

{ #category : #testing }
GtPharoStreamingMethodsCoderElementSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	See {{gtMethod:BeaconSignal class>>gtNormalOperationSignal}} for a description"

	^ true.
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderElementSignal >> element [
	^ element
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderElementSignal >> element: anObject [
	element := anObject
]

{ #category : #'gt - extensions' }
GtPharoStreamingMethodsCoderElementSignal >> gtElementPreviewFor: aView [
	<gtView>
	^ aView forward
		title: 'Element';
		priority: 0;
		object: [ self element gtPreviewElement asScalableElement maxScale: 1 ];
		view: #gtLiveFor:
]

{ #category : #printing }
GtPharoStreamingMethodsCoderElementSignal >> printOneLineContentsOn: stream [
	super printOneLineContentsOn: stream.

	stream print: element
]
