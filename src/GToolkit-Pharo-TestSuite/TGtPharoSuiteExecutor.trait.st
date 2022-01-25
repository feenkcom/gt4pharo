Trait {
	#name : #TGtPharoSuiteExecutor,
	#category : #'GToolkit-Pharo-TestSuite-Executor'
}

{ #category : #'api - testing' }
TGtPharoSuiteExecutor >> isLocal [

	"Return true if execution happens in the same image (process)."

	^ false
]

{ #category : #'api - testing' }
TGtPharoSuiteExecutor >> isRemote [

	"Return true if execution happens in another image (process)."

	^ false
]

{ #category : #'api - execution' }
TGtPharoSuiteExecutor >> playSelectedInMethodsCoder: aMethodsCoder [

	"Execute test cases of a given methods coder.
	TODO: remove it"

	self explicitRequirement
]

{ #category : #'api - execution' }
TGtPharoSuiteExecutor >> playStreamForSuiteStream: aSuiteCaseStream [
	"Execute a given test case / example"
	<return: #TAsyncStream>

	self explicitRequirement
]

{ #category : #'api - execution' }
TGtPharoSuiteExecutor >> playSuiteCase: aSuiteCase [
	"Execute a given test case / example"

	self explicitRequirement
]
