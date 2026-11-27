"
I remove the {{gtClass:GtPharoDummyEnvironment}} instances created during a managed test or example run when it ends, so examples need no `<after:>` clean up.
{{gtMethod:GtPharoDummyEnvironment class>>#registerInCurrentExecutionEnvironment:}} registers every new environment with me. {{gtMethod:GtPharoDummyEnvironmentTestService>>#cleanUpAfterTest}} sends {{gtMethod:GtPharoDummyEnvironment>>#removeFromSystem}} to each of them.
In an unmanaged example run (e.g. a user plays an example in a coder) I am disabled, see {{gtMethod:TestExecutionService>>#isEnabledInUnmanagedExampleRuns}}, and do not register anything. The environment stays available for exploration and the garbage collector removes it eventually through {{gtMethod:GtPharoDummyEnvironment>>#finalize}}.
See {{gtClass:GtPharoDummyEnvironmentTestServiceExamples}}.
"
Class {
	#name : #GtPharoDummyEnvironmentTestService,
	#superclass : #TestExecutionService,
	#instVars : [
		'environments',
		'mutex'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Dummies'
}

{ #category : #cleanup }
GtPharoDummyEnvironmentTestService >> cleanUpAfterTest [
	| someEnvironments |
	super cleanUpAfterTest.

	someEnvironments := mutex
			critical: [ | aCollection |
				aCollection := environments.
				environments := OrderedCollection new.
				aCollection ].
	someEnvironments
		do: [ :each | [ each removeFromSystem ] 
			on: Error 
			do: [ :anError | 
				GtSystemUtility reportCatchedException: anError named: 'Remove dummy environment'. 
				anError return ] ]
]

{ #category : #accessing }
GtPharoDummyEnvironmentTestService >> environments [
	^ mutex critical: [ environments copy ]
]

{ #category : #initialization }
GtPharoDummyEnvironmentTestService >> initialize [
	super initialize.

	mutex := Mutex new.
	environments := OrderedCollection new
]

{ #category : #registration }
GtPharoDummyEnvironmentTestService >> register: aDummyEnvironment [
	self isEnabled ifFalse: [ ^ self ].

	mutex critical: [ environments add: aDummyEnvironment ]
]
