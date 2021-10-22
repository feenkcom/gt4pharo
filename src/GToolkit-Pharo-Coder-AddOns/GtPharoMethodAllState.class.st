Class {
	#name : #GtPharoMethodAllState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #testing }
GtPharoMethodAllState class >> includesCoder: aCoder [

	^ aCoder testCase canExecute
]

{ #category : #accessing }
GtPharoMethodAllState class >> label [
	"Return a textural representation"
	^ 'All'
]

{ #category : #accessing }
GtPharoMethodAllState class >> numberOfMethodsIn: aMethodsCoder [

	^ aMethodsCoder testSuite numberOfAllTestCases
]

{ #category : #testing }
GtPharoMethodAllState class >> representsTestResult: aTestResult [

	^ false
]
