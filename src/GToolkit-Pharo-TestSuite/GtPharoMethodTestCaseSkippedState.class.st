"
I represent a state in which a test case that was skipped instead of an execution.
"
Class {
	#name : #GtPharoMethodTestCaseSkippedState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : 'GToolkit-Pharo-TestSuite-States'
}

{ #category : #visiting }
GtPharoMethodTestCaseSkippedState class >> accept: aVisitor [
	^ aVisitor visitTestCaseSkippedState: self
]

{ #category : #accessing }
GtPharoMethodTestCaseSkippedState class >> label [
	^ 'Skipped'
]

{ #category : #testing }
GtPharoMethodTestCaseSkippedState class >> representsTestResult: aTestResult [
	^ aTestResult skippedCount isZero not
]
