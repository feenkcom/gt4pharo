Class {
	#name : #GtPharoMethodTestCaseNotPassedState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : #'GToolkit-Pharo-TestSuite-States'
}

{ #category : #'as yet unclassified' }
GtPharoMethodTestCaseNotPassedState class >> color [
	^ BrGlamorousColors paleFailureBackgroundColor
]

{ #category : #testing }
GtPharoMethodTestCaseNotPassedState class >> includesCoder: aCoder [

	^ aCoder testCase canExecute
]

{ #category : #testing }
GtPharoMethodTestCaseNotPassedState class >> includesTestCase: aPharoTestCase [
	<return: #Boolean>
	^(aPharoTestCase state = GtPharoMethodTestCasePassedState) not
]

{ #category : #accessing }
GtPharoMethodTestCaseNotPassedState class >> label [
	^ 'Not Passed'
]

{ #category : #testing }
GtPharoMethodTestCaseNotPassedState class >> representsTestResult: aTestResult [
	^false
]
