Class {
	#name : 'GtFutureError',
	#superclass : 'Error',
	#instVars : [
		'exception'
	],
	#category : 'GToolkit-Futures-Execution'
}

{ #category : 'signalling' }
GtFutureError class >> signalForException: anError [

	^ self new
		exception: anError;
		signal
]

{ #category : 'accessing' }
GtFutureError >> exception [

	^ exception
]

{ #category : 'accessing' }
GtFutureError >> exception: anObject [

	exception := anObject
]
