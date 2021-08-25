Extension { #name : 'BlockClosure' }

{ #category : '*GToolkit-Futures' }
BlockClosure >> gtFuture [
	^ GtPollFuture pollBlock: self
]
