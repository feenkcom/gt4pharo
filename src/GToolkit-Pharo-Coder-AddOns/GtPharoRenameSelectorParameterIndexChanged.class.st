Class {
	#name : #GtPharoRenameSelectorParameterIndexChanged,
	#superclass : #GtPharoRenameSelectorParameterModelAnnouncement,
	#instVars : [
		'currentIndex'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorParameterIndexChanged >> currentIndex [
	^ currentIndex
]

{ #category : #accessing }
GtPharoRenameSelectorParameterIndexChanged >> currentIndex: anObject [
	currentIndex := anObject
]
