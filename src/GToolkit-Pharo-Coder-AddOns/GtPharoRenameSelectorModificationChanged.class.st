Class {
	#name : #GtPharoRenameSelectorModificationChanged,
	#superclass : #GtPharoRenameSelectorModelAnnouncement,
	#instVars : [
		'isModified'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorModificationChanged >> isModified [
	^ isModified
]

{ #category : #accessing }
GtPharoRenameSelectorModificationChanged >> isModified: anObject [
	isModified := anObject
]
