Class {
	#name : 'GtFuturePollPending',
	#superclass : 'GtFuturePoll',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'GToolkit-Futures-Execution'
}

{ #category : 'cleanup' }
GtFuturePollPending class >> cleanUp [
	uniqueInstance := nil
]

{ #category : 'accessing' }
GtFuturePollPending class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'testing' }
GtFuturePollPending >> isPending [
	^ true
]

{ #category : 'testing' }
GtFuturePollPending >> isReady [
	^ false
]

{ #category : 'operators-mapping' }
GtFuturePollPending >> map: aBlock [
	"Changes the ready value of this Poll with the value computed."
	<return: #GtFuturePoll>
	
	^ self
]
