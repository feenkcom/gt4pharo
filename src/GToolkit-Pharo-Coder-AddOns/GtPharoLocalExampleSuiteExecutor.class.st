Class {
	#name : #GtPharoLocalExampleSuiteExecutor,
	#superclass : #Object,
	#traits : 'TGtPharoSuiteExecutor',
	#classTraits : 'TGtPharoSuiteExecutor classTrait',
	#category : #'GToolkit-Pharo-Coder-AddOns-Examples'
}

{ #category : #'api - testing' }
GtPharoLocalExampleSuiteExecutor >> isLocal [

	^ true
]

{ #category : #accessing }
GtPharoLocalExampleSuiteExecutor >> playSelectedInMethodsCoder: aMethodsCoder [

	"Execute examples of a given methods coder"

	aMethodsCoder exampler runExamples
]
