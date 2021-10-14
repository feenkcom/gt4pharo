Class {
	#name : #GtPharoMethodTestCaseSkippedState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #testing }
GtPharoMethodTestCaseSkippedState class >> representsTestResult: aTestResult [
	^ aTestResult skippedCount isZero not
]

{ #category : #visiting }
GtPharoMethodTestCaseSkippedState >> accept: aVisitor [
	^ aVisitor visitTestCaseSkippedState: self
]

{ #category : #accessing }
GtPharoMethodTestCaseSkippedState >> color [
	^ BrGlamorousColors neutralBackgroundColor
]

{ #category : #accessing }
GtPharoMethodTestCaseSkippedState >> label [
	^ 'Skipped'
]
