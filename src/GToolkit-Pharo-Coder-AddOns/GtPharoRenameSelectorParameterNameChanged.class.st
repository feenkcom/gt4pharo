Class {
	#name : #GtPharoRenameSelectorParameterNameChanged,
	#superclass : #Announcement,
	#instVars : [
		'currentName'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorParameterNameChanged >> currentName [
	^ currentName
]

{ #category : #accessing }
GtPharoRenameSelectorParameterNameChanged >> currentName: anObject [
	currentName := anObject
]
