Trait {
	#name : #TGtPharoSuiteViewModel,
	#instVars : [
		'selectedState'
	],
	#category : 'GToolkit-Pharo-TestSuite-UI-! View Models'
}

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> allStates [
	"Return all suite states that can be displays to users as summary."

	^ self explicitRequirement
]

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> allSuiteCases [
	<return: #TAsyncStream>
	
	^ self explicitRequirement
]

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> allSuiteCasesState [
	^ self explicitRequirement
]

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> allSuiteStates [
	"Return a stream of all unique states in the suite"
	<return: #TAsyncStream>

	^ self explicitRequirement
]

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> beLocalFrom: aSource [

	"Set local executor"

	self explicitRequirement
]

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> beRemoteFrom: aSource [

	"Set remote executor"

	self explicitRequirement
]

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> executionDetail [

	"Return an object that represents execution state, e.g., exception in case execution failure."

	^ self explicitRequirement
]

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> executionError: anError [
	self explicitRequirement
]

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> executor [

	<return: #TGtPharoSuiteExecutor>
	^ self explicitRequirement
]

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> hasExecutionError [

	"Return true if there is an execution error."

	^ self explicitRequirement
]

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> hasPendingExecution [
	"Return true if an execution is happening (or about to happen)."

	^ self explicitRequirement
]

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> hasSuiteCases [
	"Return a future which resolves to true if there is at least one suite case, false otherwise"
	<return: #TAsyncFuture>
	
	^ self explicitRequirement
]

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> isLocal [

	^ self executor isLocal
]

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> isRemote [

	^ self executor isRemote
]

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> playFrom: anElement [

	"Perform a suite, e.g., test suite, examples.
	anElement is a widget from which the request comes from."

	<return: #TAsyncStream>
	| aSelectedState aStream |
	aSelectedState := selectedState.
	aStream := self allSuiteCases filter: [ :eachSuiteCase | 
		           aSelectedState = self allSuiteCasesState or: [ 
			           (self suiteCaseStateOf: eachSuiteCase) = aSelectedState ] ].

	^ self executor playStreamForSuiteStream: aStream
]

{ #category : #'api - accessing' }
TGtPharoSuiteViewModel >> selectedState [
	^ selectedState
]

{ #category : #'api - accessing' }
TGtPharoSuiteViewModel >> selectedState: anObject [
	selectedState := anObject.
	self announce: (GtPharoSuiteSelectedStateChanged new state: anObject)
]

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> suiteCaseStateOf: aSuiteCaseObject [
	^ self explicitRequirement
]
