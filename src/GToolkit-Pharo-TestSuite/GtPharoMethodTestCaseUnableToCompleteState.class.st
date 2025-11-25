Class {
	#name : #GtPharoMethodTestCaseUnableToCompleteState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : 'GToolkit-Pharo-TestSuite-States'
}

{ #category : #visiting }
GtPharoMethodTestCaseUnableToCompleteState class >> accept: aVisitor [
	^ aVisitor visitTestCaseUnableToCompleteState: self
]

{ #category : #accessing }
GtPharoMethodTestCaseUnableToCompleteState class >> label [
	^ 'Unable to Complete'
]

{ #category : #testing }
GtPharoMethodTestCaseUnableToCompleteState class >> representsTestResult: aTestResult [
	^	false
]
