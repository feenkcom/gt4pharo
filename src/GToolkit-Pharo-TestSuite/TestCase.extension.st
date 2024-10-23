Extension { #name : #TestCase }

{ #category : #'*GToolkit-Pharo-TestSuite' }
TestCase >> debug [
	<gtPharoPatch: #Pharo>
	"During the execution, if the receiver fails
	due to an error or an assertion failure,
	I open the debuger so user can see the context of failure"

	| result |
	result := self classForTestResult new.
	^ self debug: result
]

{ #category : #'*GToolkit-Pharo-TestSuite' }
TestCase >> debug: aResult [
	"During the execution, if the receiver fails
	due to an error or an assertion failure,
	I open the debuger so user can see the context of failure"

	[ aResult runCaseForDebug: self ] ensure: [
		self classForTestResource resetResources: self resources.
		aResult updateResultsInHistory ].
	^ aResult
]

{ #category : #'*GToolkit-Pharo-TestSuite' }
TestCase >> isGtExample [

	^ false
]
