Class {
	#name : #GtPharoLocalTestSuiteExecutor,
	#superclass : #Object,
	#traits : 'TGtPharoSuiteExecutor',
	#classTraits : 'TGtPharoSuiteExecutor classTrait',
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #'api - testing' }
GtPharoLocalTestSuiteExecutor >> isLocal [

	^ true
]

{ #category : #'api - execution' }
GtPharoLocalTestSuiteExecutor >> playSelectedInMethodsCoder: aMethodsCoder [

	"Execute test cases of a given methods coder"

	aMethodsCoder testSuite playSelected
]
