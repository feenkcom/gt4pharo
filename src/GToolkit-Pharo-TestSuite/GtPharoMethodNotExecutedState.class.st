"
I represent a state in which a test case was not executed.

"
Class {
	#name : #GtPharoMethodNotExecutedState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : 'GToolkit-Pharo-TestSuite-States'
}

{ #category : #visiting }
GtPharoMethodNotExecutedState class >> accept: aVisitor [
	^ aVisitor visitTestCaseNotExecutedState: self
]

{ #category : #accessing }
GtPharoMethodNotExecutedState class >> beSkipped: aGtPharoMethodTestCase [
	aGtPharoMethodTestCase state: GtPharoMethodTestCaseSkippedState
]

{ #category : #accessing }
GtPharoMethodNotExecutedState class >> label [
	^ 'Not Executed'
]

{ #category : #testing }
GtPharoMethodNotExecutedState class >> representsTestResult: aTestResult [
	^ false
]
