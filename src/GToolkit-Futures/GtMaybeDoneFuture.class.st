Class {
	#name : 'GtMaybeDoneFuture',
	#superclass : 'Object',
	#traits : 'TGtFuture',
	#classTraits : 'TGtFuture classTrait',
	#instVars : [
		'state'
	],
	#category : 'GToolkit-Futures-Futures'
}

{ #category : 'instance creation' }
GtMaybeDoneFuture class >> future: aFuture [
	^ self new setFuture: aFuture
]

{ #category : 'api - future' }
GtMaybeDoneFuture >> await [
	^ (GtTaskItFutureTask new forFuture: self) future: TKTConfiguration runner
]

{ #category : 'api - future' }
GtMaybeDoneFuture >> poll: anAsynchronousContext [
	state key = #gone
		ifTrue: [ self error: ('{1} is polled after being taken' format: { self printString }) ].

	state key = #future
		ifTrue: [
			(state value poll: anAsynchronousContext)
				ifReady: [ :aReadyPoll | self setDone: aReadyPoll value ]
				ifPending: [ :aPendingPoll | ^ aPendingPoll ] ].
			
	^ GtFuturePollReady new
]

{ #category : 'initialization' }
GtMaybeDoneFuture >> setDone: anObject [
	state := #done -> anObject
]

{ #category : 'initialization' }
GtMaybeDoneFuture >> setFuture: aFuture [
	state := #future -> aFuture
]

{ #category : 'initialization' }
GtMaybeDoneFuture >> setGone [
	state := #gone -> nil
]

{ #category : 'accessing' }
GtMaybeDoneFuture >> takeOutput [
	^ self
		takeOutput: [ :aValue | aValue ]
		ifNone: [ self error: 'The future is not done or the outout is already taken' ]
]

{ #category : 'accessing' }
GtMaybeDoneFuture >> takeOutput: aBlock ifNone: aNoneBlock [
	^ state key = #done
		ifTrue: [
			| aValue |
			
			aValue := state value.
			self setGone.
			aBlock value: aValue ]
		ifFalse: aNoneBlock
]
