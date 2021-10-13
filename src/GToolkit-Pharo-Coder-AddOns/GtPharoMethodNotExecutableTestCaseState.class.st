Class {
	#name : #GtPharoMethodNotExecutableTestCaseState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #accessing }
GtPharoMethodNotExecutableTestCaseState class >> representsTestResult: aTestResult [
	^ false
]

{ #category : #accessing }
GtPharoMethodNotExecutableTestCaseState >> color [
	^ Color transparent
]

{ #category : #accessing }
GtPharoMethodNotExecutableTestCaseState >> label [
	^ 'Not Executable'
]
