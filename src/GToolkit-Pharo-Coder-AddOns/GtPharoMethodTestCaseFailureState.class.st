Class {
	#name : #GtPharoMethodTestCaseFailureState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #testing }
GtPharoMethodTestCaseFailureState class >> representsTestResult: aTestResult [
	^ aTestResult hasFailures
]

{ #category : #accessing }
GtPharoMethodTestCaseFailureState >> color [
	^ BrGlamorousColors failureBackgroundColor
]

{ #category : #accessing }
GtPharoMethodTestCaseFailureState >> label [
	^ 'Failure'
]
