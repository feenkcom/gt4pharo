Class {
	#name : #GtPharoMethodExecutingState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : #'GToolkit-Pharo-TestSuite-States'
}

{ #category : #accessing }
GtPharoMethodExecutingState class >> representsTestResult: aTestResult [
	^ false
]

{ #category : #accessing }
GtPharoMethodExecutingState >> accept: aVisitor [
	^ aVisitor visitTestCaseexecutingState: self
]

{ #category : #accessing }
GtPharoMethodExecutingState >> color [
	^ Color blue
]

{ #category : #accessing }
GtPharoMethodExecutingState >> label [
	^ 'Executing'
]
