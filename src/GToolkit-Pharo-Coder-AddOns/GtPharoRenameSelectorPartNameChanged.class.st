Class {
	#name : #GtPharoRenameSelectorPartNameChanged,
	#superclass : #GtPharoRenameSelectorPartModelAnnouncement,
	#instVars : [
		'currentName',
		'isModified',
		'displayName'
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

{ #category : #accessing }
GtPharoRenameSelectorPartNameChanged >> displayName [
	^ displayName
]

{ #category : #accessing }
GtPharoRenameSelectorPartNameChanged >> displayName: anObject [
	displayName := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorPartNameChanged >> isModified [
	^ isModified
]

{ #category : #accessing }
GtPharoRenameSelectorPartNameChanged >> isModified: anObject [
	isModified := anObject
]
