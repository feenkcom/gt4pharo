Class {
	#name : #GtPharoMethodAllState,
	#superclass : #GtPharoMethodTestCaseState,
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #testing }
GtPharoMethodAllState class >> representsTestResult: aTestResult [

	^ false
]

{ #category : #testing }
GtPharoMethodAllState >> includesCoder: aCoder [

	^ aCoder testCase canExecute
]

{ #category : #accessing }
GtPharoMethodAllState >> label [
	"Return a textural representation"
	^ 'All'
]

{ #category : #accessing }
GtPharoMethodAllState >> numberOfMethodsIn: aMethodsCoder [

	^ aMethodsCoder testSuite numberOfAllTestCases
]
