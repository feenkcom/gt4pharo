Class {
	#name : #GtPharoMethodTestCasePassedState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #testing }
GtPharoMethodTestCasePassedState class >> representsTestResult: aTestResult [
	^ aTestResult passedCount isZero not
]

{ #category : #visiting }
GtPharoMethodTestCasePassedState >> accept: aVisitor [
	^ aVisitor visitTestCasePassedState: self
]

{ #category : #accessing }
GtPharoMethodTestCasePassedState >> color [
	^ BrGlamorousColors successBackgroundColor
]

{ #category : #accessing }
GtPharoMethodTestCasePassedState >> label [
	^ 'Success'
]
