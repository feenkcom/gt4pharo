Trait {
	#name : 'TGtFuture',
	#category : 'GToolkit-Futures-Futures'
}

{ #category : 'api - future' }
TGtFuture >> await [
	^ (GtTaskItFutureTask new forFuture: self) future: TKTConfiguration runner
]

{ #category : 'api - future' }
TGtFuture >> map: aBlock [
	^ GtMapFuture future: self mapBlock: aBlock
]

{ #category : 'api - future' }
TGtFuture >> poll: anAsynchronousContext [
	self explicitRequirement
]

{ #category : 'api - future' }
TGtFuture >> wait [
	| aSemaphore anAwaitResult anAwaitError |
	
	aSemaphore := Semaphore new.
	
	self await
		onSuccessDo: [ :aResult |
			anAwaitResult := aResult.
			aSemaphore signal ];
		onFailureDo: [ :anError |
			anAwaitError := anError freezeOrWithoutContext.
			aSemaphore signal ].
	
	aSemaphore wait.
	anAwaitError ifNotNil: [ GtFutureError signalForException: anAwaitError ].
	^ anAwaitResult
]
