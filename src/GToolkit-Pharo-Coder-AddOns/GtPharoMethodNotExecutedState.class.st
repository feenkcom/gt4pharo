Class {
	#name : #GtPharoMethodNotExecutedState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #testing }
GtPharoMethodNotExecutedState class >> representsTestResult: aTestResult [
	^ false
]

{ #category : #visiting }
GtPharoMethodNotExecutedState >> accept: aVisitor [
	^ aVisitor visitTestCaseNotExecutedState: self
]

{ #category : #accessing }
GtPharoMethodNotExecutedState >> color [
	^ BrGlamorousColors neutralBackgroundColor
]

{ #category : #accessing }
GtPharoMethodNotExecutedState >> label [
	^ 'Not Executed'
]
