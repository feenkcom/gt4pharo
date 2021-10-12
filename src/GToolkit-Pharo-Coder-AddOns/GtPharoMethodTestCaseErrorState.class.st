Class {
	#name : #GtPharoMethodTestCaseErrorState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #testing }
GtPharoMethodTestCaseErrorState class >> representsTestResult: aTestResult [
	^ aTestResult hasErrors
]

{ #category : #accessing }
GtPharoMethodTestCaseErrorState >> color [
	^ BrGlamorousColors errorBackgroundColor
]

{ #category : #accessing }
GtPharoMethodTestCaseErrorState >> label [
	^ 'Error'
]
