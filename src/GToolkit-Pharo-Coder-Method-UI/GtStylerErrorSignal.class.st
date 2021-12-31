Class {
	#name : #GtStylerErrorSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'error'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Stylers'
}

{ #category : #testing }
GtStylerErrorSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	See {{gtMethod:BeaconSignal class>>gtNormalOperationSignal}} for a description"

	^ true.
]

{ #category : #'api - styling' }
GtStylerErrorSignal >> signaledError: anError [ 
	error := anError
]
