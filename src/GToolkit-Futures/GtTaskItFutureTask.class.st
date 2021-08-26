Class {
	#name : 'GtTaskItFutureTask',
	#superclass : 'TKTTask',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'future'
	],
	#category : 'GToolkit-Futures-Execution'
}

{ #category : 'accessing' }
GtTaskItFutureTask >> entryIdentifier [
	"Answer the queue entry identifier of the receiver for task scheduling.
	Defer to my command."

	^ nil
]

{ #category : 'accessing' }
GtTaskItFutureTask >> entryPriority [
	^ 1
]

{ #category : 'accessing' }
GtTaskItFutureTask >> forFuture: aGtFuture [
	future := aGtFuture
]

{ #category : 'executing' }
GtTaskItFutureTask >> futureTaskExecutionFor: aRunner [
	^ self configureTaskExecution: GtFutureExecution new with: aRunner
]

{ #category : 'accessing' }
GtTaskItFutureTask >> name [
	<return: #String>

	^ future class
]

{ #category : 'executing' }
GtTaskItFutureTask >> scheduleTaskExecutionFor: aRunner [
	^ self configureTaskExecution: GtFutureExecution new with: aRunner
]

{ #category : 'executing' }
GtTaskItFutureTask >> value [
	self
		assert: [ future notNil ]
		description: [ 'Future must be initialized before using it' ].

	^ future poll: self
]
