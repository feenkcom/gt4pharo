"
I am an {{gtClass:Announcement}}.
I am emitted by {{gtClass:GtPharoMethodTestCase}}.

"
Class {
	#name : #GtPharoMethodTestCaseAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'testCase'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #accessing }
GtPharoMethodTestCaseAnnouncement >> testCase [
	^ testCase
]

{ #category : #accessing }
GtPharoMethodTestCaseAnnouncement >> testCase: aTestCase [
	testCase := aTestCase
]
