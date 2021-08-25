Class {
	#name : 'GtJoinAllFuture',
	#superclass : 'Object',
	#traits : 'TGtFuture',
	#classTraits : 'TGtFuture classTrait',
	#instVars : [
		'futures'
	],
	#category : 'GToolkit-Futures-Futures'
}

{ #category : 'instance creation' }
GtJoinAllFuture class >> futures: aCollectionOfFutures [
	^ self new futures: aCollectionOfFutures
]

{ #category : 'initialization' }
GtJoinAllFuture >> futures: aCollectionOfFutures [
	futures := aCollectionOfFutures collect: [ :eachFuture | GtMaybeDoneFuture future: eachFuture ] as: Array
]

{ #category : 'api - future' }
GtJoinAllFuture >> poll: anAsynchronousContext [
	| allDone |
	
	allDone := true.
	futures do: [ :eachFuture | 
		(eachFuture poll: anAsynchronousContext) isPending ifTrue: [ 
			allDone := false ] ].

	^ allDone
		  ifTrue: [ 
			  GtFuturePollReady value: (futures
					   collect: [ :eachMaybeDoneFuture | 
					   eachMaybeDoneFuture takeOutput ]
					   as: Array) ]
		  ifFalse: [ GtFuturePoll pending ]
]
