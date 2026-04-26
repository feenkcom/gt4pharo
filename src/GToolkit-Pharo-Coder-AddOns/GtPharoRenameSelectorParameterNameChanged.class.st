Class {
	#name : #GtPharoRenameSelectorParameterNameChanged,
	#superclass : #GtPharoRenameSelectorParameterModelAnnouncement,
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
