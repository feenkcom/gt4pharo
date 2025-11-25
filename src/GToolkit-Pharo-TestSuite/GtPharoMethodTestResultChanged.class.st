"
I am an {{gtClass:Announcement}}.
I am emitted by {{gtClass:GtPharoMethodTestCase}}.
I notify that a {{gtClass:TestResult}} was changed.
"
Class {
	#name : #GtPharoMethodTestResultChanged,
	#superclass : #GtPharoMethodTestCaseAnnouncement,
	#instVars : [
		'result'
	],
	#category : 'GToolkit-Pharo-TestSuite-Events'
}

{ #category : #accessing }
GtPharoMethodTestResultChanged >> result [
	result
]

{ #category : #accessing }
GtPharoMethodTestResultChanged >> result: aTestResult [
	result := aTestResult
]
