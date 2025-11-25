Class {
	#name : #GtPharoMethodTestCaseAllState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : 'GToolkit-Pharo-TestSuite-States'
}

{ #category : #accessing }
GtPharoMethodTestCaseAllState class >> allTestCasesIn: aTestSuite [
	<return: #TAsyncStream>

	^ aTestSuite allTestCases
]

{ #category : #testing }
GtPharoMethodTestCaseAllState class >> includesCoder: aCoder [

	^ aCoder testCase canExecute
]

{ #category : #testing }
GtPharoMethodTestCaseAllState class >> includesTestCase: aPharoTestCase [
	<return: #Boolean>

	^ true
]

{ #category : #accessing }
GtPharoMethodTestCaseAllState class >> label [
	"Return a textural representation"
	^ 'All tests'
]

{ #category : #accessing }
GtPharoMethodTestCaseAllState class >> numberOfMethodsIn: aTestSuite [
	<return: #TAsyncFuture>

	^ aTestSuite numberOfAllTestCases
]

{ #category : #testing }
GtPharoMethodTestCaseAllState class >> representsTestResult: aTestResult [

	^ false
]
