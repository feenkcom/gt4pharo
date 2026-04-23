Class {
	#name : #GtPharoRenameSelectorPartNameChanged,
	#superclass : #Announcement,
	#instVars : [
		'currentName'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorPartNameChanged >> currentName [
	^ currentName
]

{ #category : #accessing }
GtPharoRenameSelectorPartNameChanged >> currentName: anObject [
	currentName := anObject
]
