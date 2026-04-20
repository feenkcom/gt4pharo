Class {
	#name : #GtPharoRenameSelectorKeywordNameChanged,
	#superclass : #Announcement,
	#instVars : [
		'currentName'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorKeywordNameChanged >> currentName [
	^ currentName
]

{ #category : #accessing }
GtPharoRenameSelectorKeywordNameChanged >> currentName: anObject [
	currentName := anObject
]
