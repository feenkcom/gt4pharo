Extension { #name : 'Object' }

{ #category : '*GToolkit-Futures' }
Object >> asFuturePoll [
	^ GtFuturePollReady value: self
]
