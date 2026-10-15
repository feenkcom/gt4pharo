Class {
	#name : #GtPharoRenameVariableNameChanged,
	#superclass : #GtPharoRenameVariableModelAnnouncement,
	#instVars : [
		'currentName',
		'isModified'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameVariableNameChanged >> currentName [
	^ currentName
]

{ #category : #accessing }
GtPharoRenameVariableNameChanged >> currentName: anObject [
	currentName := anObject
]

{ #category : #accessing }
GtPharoRenameVariableNameChanged >> isModified [
	^ isModified
]

{ #category : #accessing }
GtPharoRenameVariableNameChanged >> isModified: anObject [
	isModified := anObject
]
