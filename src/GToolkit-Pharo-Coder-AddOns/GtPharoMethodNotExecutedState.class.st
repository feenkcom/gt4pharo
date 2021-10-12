Class {
	#name : #GtPharoMethodNotExecutedState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #testing }
GtPharoMethodNotExecutedState class >> representsTestResult: aTestResult [
	^ false
]

{ #category : #accessing }
GtPharoMethodNotExecutedState >> color [
	^ BrGlamorousColors neutralBackgroundColor
]

{ #category : #accessing }
GtPharoMethodNotExecutedState >> label [
	^ 'Not Executed'
]
