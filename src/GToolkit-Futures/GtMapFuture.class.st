Class {
	#name : 'GtMapFuture',
	#superclass : 'Object',
	#traits : 'TGtFuture',
	#classTraits : 'TGtFuture classTrait',
	#instVars : [
		'future',
		'mapBlock'
	],
	#category : 'GToolkit-Futures-Futures'
}

{ #category : 'instance creation' }
GtMapFuture class >> future: aFuture mapBlock: aBlock [
	^ self new future: aFuture mapBlock: aBlock
]

{ #category : 'api - future' }
GtMapFuture >> await [
	^ (GtTaskItFutureTask new forFuture: self) future: TKTConfiguration runner
]

{ #category : 'initialization' }
GtMapFuture >> future: aFuture mapBlock: aBlock [
	future := aFuture.
	mapBlock := aBlock
]

{ #category : 'api - future' }
GtMapFuture >> poll: anAsynchronousContext [
	^ (future poll: anAsynchronousContext)
		ifReady: [ :aReadyPoll | aReadyPoll map: mapBlock ]
		ifPending: [ :aPendingPoll | aPendingPoll ]
]
