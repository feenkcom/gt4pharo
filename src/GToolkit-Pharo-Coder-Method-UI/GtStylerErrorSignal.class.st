Class {
	#name : #GtStylerErrorSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'error'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Stylers'
}

{ #category : #'api - styling' }
GtStylerErrorSignal >> signaledError: anError [ 
	error := anError
]
