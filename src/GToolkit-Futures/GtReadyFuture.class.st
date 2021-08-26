"
A future that is immediately ready with a value.
"
Class {
	#name : 'GtReadyFuture',
	#superclass : 'Object',
	#traits : 'TGtFuture',
	#classTraits : 'TGtFuture classTrait',
	#instVars : [
		'value'
	],
	#category : 'GToolkit-Futures-Futures'
}

{ #category : 'api - future' }
GtReadyFuture >> await [
	^ (GtTaskItFutureTask new forFuture: self) future: TKTConfiguration runner
]

{ #category : 'api - future' }
GtReadyFuture >> poll: anAsynchronousContext [
	| aValue |

	self
		assert: [ value notNil ]
		description: [ 'Value already polled' ].

	aValue := value.
	value := nil.

	^ GtFuturePollReady value: aValue
]

{ #category : 'initialization' }
GtReadyFuture >> value: anObject [
	value := anObject
]
