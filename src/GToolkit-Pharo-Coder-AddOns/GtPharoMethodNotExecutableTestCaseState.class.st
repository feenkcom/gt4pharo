"
I represent a state in which a method is not a test case.
It may happen when a test case method source code is modified.

"
Class {
	#name : #GtPharoMethodNotExecutableTestCaseState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #accessing }
GtPharoMethodNotExecutableTestCaseState class >> accept: aVisitor [
	^ aVisitor visitTestCaseNotExecutableState: self
]

{ #category : #accessing }
GtPharoMethodNotExecutableTestCaseState class >> color [
	^ Color transparent
]

{ #category : #accessing }
GtPharoMethodNotExecutableTestCaseState class >> label [
	^ 'Not Executable'
]

{ #category : #accessing }
GtPharoMethodNotExecutableTestCaseState class >> representsTestResult: aTestResult [
	^ false
]
