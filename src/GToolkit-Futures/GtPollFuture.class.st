Class {
	#name : 'GtPollFuture',
	#superclass : 'Object',
	#traits : 'TGtFuture',
	#classTraits : 'TGtFuture classTrait',
	#instVars : [
		'pollBlock'
	],
	#category : 'GToolkit-Futures-Futures'
}

{ #category : 'instance creation' }
GtPollFuture class >> pollBlock: aBlock [
	^ self new pollBlock: aBlock
]

{ #category : 'api - future' }
GtPollFuture >> await [
	^ (GtTaskItFutureTask new forFuture: self) future: TKTConfiguration runner
]

{ #category : 'api - future' }
GtPollFuture >> poll: anAsynchronousContext [
	^ (pollBlock cull: anAsynchronousContext) asFuturePoll
]

{ #category : 'initialization' }
GtPollFuture >> pollBlock: anObject [

	pollBlock := anObject
]
