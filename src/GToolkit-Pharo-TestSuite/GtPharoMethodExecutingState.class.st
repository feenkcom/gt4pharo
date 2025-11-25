Class {
	#name : #GtPharoMethodExecutingState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : 'GToolkit-Pharo-TestSuite-States'
}

{ #category : #accessing }
GtPharoMethodExecutingState class >> accept: aVisitor [
	^ aVisitor visitTestCaseexecutingState: self
]

{ #category : #accessing }
GtPharoMethodExecutingState class >> label [
	^ 'Executing'
]

{ #category : #accessing }
GtPharoMethodExecutingState class >> representsTestResult: aTestResult [
	^ false
]
