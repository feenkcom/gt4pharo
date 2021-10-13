Class {
	#name : #GtPharoMethodTestResultChanged,
	#superclass : #Announcement,
	#instVars : [
		'testCase',
		'result'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #accessing }
GtPharoMethodTestResultChanged >> result [
	result
]

{ #category : #accessing }
GtPharoMethodTestResultChanged >> result: aTestResult [
	result := aTestResult
]

{ #category : #accessing }
GtPharoMethodTestResultChanged >> testCase [
	^ testCase
]

{ #category : #accessing }
GtPharoMethodTestResultChanged >> testCase: aTestCase [
	testCase := aTestCase
]
