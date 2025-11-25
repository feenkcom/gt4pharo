"
I represent a state in which a test case that was executed properly, satisfying all assertions.
"
Class {
	#name : #GtPharoMethodTestCasePassedState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : 'GToolkit-Pharo-TestSuite-States'
}

{ #category : #visiting }
GtPharoMethodTestCasePassedState class >> accept: aVisitor [
	^ aVisitor visitTestCasePassedState: self
]

{ #category : #accessing }
GtPharoMethodTestCasePassedState class >> label [
	^ 'Passed'
]

{ #category : #testing }
GtPharoMethodTestCasePassedState class >> representsTestResult: aTestResult [
	^ aTestResult passedCount isZero not
]
