Trait {
	#name : #TGtPharoSuiteViewModel,
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> allStates [

	"Return all suite states that can be displays to users as summary."

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
TGtPharoSuiteViewModel >> hasSelectedExecutableSuiteItems [

	"Return true if there are executable suite items"

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
	
	self explicitRequirement
]

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> totalStringForState: aState [

	"Return string representing amount of items for a given state, 
	e.g., '6 examples' for success state."
	
	^ self explicitRequirement
]

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> updateCoderFilterWith: aState source: aSource [

	"Update MethodsCoder filters based on aState.
	aSource is an element that requests the change."

	^ self explicitRequirement
]
