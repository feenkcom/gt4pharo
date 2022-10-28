Class {
	#name : #GtPharoMethodExecutingState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : #'GToolkit-Pharo-TestSuite-States'
}

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

{ #category : #accessing }
GtPharoMethodExecutingState >> representsTestResult: aTestResult [
	^ false
]
