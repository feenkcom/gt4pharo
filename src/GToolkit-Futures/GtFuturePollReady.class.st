Class {
	#name : 'GtFuturePollReady',
	#superclass : 'GtFuturePoll',
	#instVars : [
		'value'
	],
	#category : 'GToolkit-Futures-Execution'
}

{ #category : 'generated' }
GtFuturePollReady class >> value: anObject [
	^ self new value: anObject
]

{ #category : 'testing' }
GtFuturePollReady >> isPending [
	^ false
]

{ #category : 'testing' }
GtFuturePollReady >> isReady [
	^ true
]

{ #category : 'operators-mapping' }
GtFuturePollReady >> map: aBlock [
	"Changes the ready value of this Poll with the value computed."
	<return: #GtFuturePoll>
	
	^ self class value: (aBlock cull: self value)
]

{ #category : 'accessing' }
GtFuturePollReady >> value [
	^ value
]

{ #category : 'accessing' }
GtFuturePollReady >> value: anObject [

	value := anObject
]
