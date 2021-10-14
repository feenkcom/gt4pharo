"
I am an {{gtClass:Announcement}}.
I am emitted by {{gtClass:GtPharoMethodTestCase}}.
I notify that a {{gtClass:GtPharoMethodTestCaseState}} was changed.
"
Class {
	#name : #GtPharoMethodTestCaseStateChanged,
	#superclass : #GtPharoMethodTestCaseAnnouncement,
	#instVars : [
		'state'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #accessing }
GtPharoMethodTestCaseStateChanged >> state [
	^ state
]

{ #category : #accessing }
GtPharoMethodTestCaseStateChanged >> state: aState [
	state := aState
]
