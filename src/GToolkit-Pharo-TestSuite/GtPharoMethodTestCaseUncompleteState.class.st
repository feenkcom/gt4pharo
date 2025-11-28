Class {
	#name : #GtPharoMethodTestCaseUncompleteState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : #'GToolkit-Pharo-TestSuite-States'
}

{ #category : #visiting }
GtPharoMethodTestCaseUncompleteState class >> accept: aVisitor [
	^ aVisitor visitTestCaseUncompletedState: self
]

{ #category : #accessing }
GtPharoMethodTestCaseUncompleteState class >> label [
	^ 'Uncomplete'
]

{ #category : #testing }
GtPharoMethodTestCaseUncompleteState class >> representsTestResult: aTestResult [
	^	false
]
