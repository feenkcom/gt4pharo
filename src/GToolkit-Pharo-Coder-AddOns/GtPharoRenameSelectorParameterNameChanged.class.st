Class {
	#name : #GtPharoRenameSelectorParameterNameChanged,
	#superclass : #Announcement,
	#instVars : [
		'parameterModel',
		'currentName',
		'source'
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

{ #category : #accessing }
GtPharoRenameSelectorParameterNameChanged >> parameterModel [
	^ parameterModel
]

{ #category : #accessing }
GtPharoRenameSelectorParameterNameChanged >> parameterModel: anObject [
	parameterModel := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorParameterNameChanged >> source [
	^ source
]

{ #category : #accessing }
GtPharoRenameSelectorParameterNameChanged >> source: anObject [
	source := anObject
]
