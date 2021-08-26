Class {
	#name : 'GtFutureExecution',
	#superclass : 'TKTFutureExecution',
	#category : 'GToolkit-Futures-Execution'
}

{ #category : 'evaluating' }
GtFutureExecution >> doExecuteTask [
	[
		| aPoll |
		aPoll := task value.
		aPoll
			ifReady: [ future deploySuccess: aPoll value ]
			ifPending: [ runner scheduleTaskExecution: self copy ] ]
		on: BlTktExplicitlyTerminatedTaskException, Error
		do: [ :error | future deployFailure: error freezeOrWithoutContext ].
]

{ #category : 'copying' }
GtFutureExecution >> postCopy [
	state := TKTReadyTaskState new.
	cancelled := nil.
	executionProcess := nil.
	isRunning := nil
]
