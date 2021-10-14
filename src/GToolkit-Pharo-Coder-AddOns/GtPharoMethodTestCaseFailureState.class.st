"
I represent a state in which a test case that produced  runtime failure.
"
Class {
	#name : #GtPharoMethodTestCaseFailureState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #testing }
GtPharoMethodTestCaseFailureState class >> representsTestResult: aTestResult [
	^ aTestResult hasFailures
]

{ #category : #visiting }
GtPharoMethodTestCaseFailureState >> accept: aVisitor [
	^ aVisitor visitTestCaseFailureState: self
]

{ #category : #accessing }
GtPharoMethodTestCaseFailureState >> color [
	^ BrGlamorousColors failureBackgroundColor
]

{ #category : #accessing }
GtPharoMethodTestCaseFailureState >> label [
	^ 'Failure'
]
