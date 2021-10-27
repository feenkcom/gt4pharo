Class {
	#name : #GtPharoTestSuiteViewModel,
	#superclass : #Object,
	#traits : 'TGtPharoSuiteViewModel',
	#classTraits : 'TGtPharoSuiteViewModel classTrait',
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #accessing }
GtPharoTestSuiteViewModel >> allStates [

	^ { 
		  GtPharoMethodAllState.
		  GtPharoMethodTestCasePassedState.
		  GtPharoMethodTestCaseSkippedState.
		  GtPharoMethodTestCaseFailureState.
		  GtPharoMethodTestCaseErrorState.
		  GtPharoMethodNotExecutedState }
]
