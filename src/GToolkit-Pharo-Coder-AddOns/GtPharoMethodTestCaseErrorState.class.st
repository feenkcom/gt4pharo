"
I represent a state in which a test case that produced  runtime error.
"
Class {
	#name : #GtPharoMethodTestCaseErrorState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #testing }
GtPharoMethodTestCaseErrorState class >> representsTestResult: aTestResult [
	^ aTestResult hasErrors
]

{ #category : #visiting }
GtPharoMethodTestCaseErrorState >> accept: aVisitor [
	^ aVisitor visitTestCaseErrorState: self
]

{ #category : #accessing }
GtPharoMethodTestCaseErrorState >> color [
	^ BrGlamorousColors errorBackgroundColor
]

{ #category : #accessing }
GtPharoMethodTestCaseErrorState >> label [
	^ 'Error'
]
