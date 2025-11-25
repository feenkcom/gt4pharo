"
I represent a state in which a test case that produced  runtime failure.
"
Class {
	#name : #GtPharoMethodTestCaseFailureState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : 'GToolkit-Pharo-TestSuite-States'
}

{ #category : #visiting }
GtPharoMethodTestCaseFailureState class >> accept: aVisitor [
	^ aVisitor visitTestCaseFailureState: self
]

{ #category : #accessing }
GtPharoMethodTestCaseFailureState class >> label [
	^ 'Failure'
]

{ #category : #testing }
GtPharoMethodTestCaseFailureState class >> representsTestResult: aTestResult [
	^ aTestResult hasFailures
]
