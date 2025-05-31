Class {
	#name : #GtBlocThemeValueHardcodedIssue,
	#superclass : #GtBlocThemeIssue,
	#instVars : [
		'themeableValue',
		'valueAssignment'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #accessing }
GtBlocThemeValueHardcodedIssue >> description [
	^ 'Hardcoded value' format: { self themeableValue valueName }
]

{ #category : #accessing }
GtBlocThemeValueHardcodedIssue >> themeableValue [
	^ themeableValue
]

{ #category : #accessing }
GtBlocThemeValueHardcodedIssue >> themeableValue: anObject [
	themeableValue := anObject
]

{ #category : #accessing }
GtBlocThemeValueHardcodedIssue >> valueAssignment [
	^ valueAssignment
]

{ #category : #accessing }
GtBlocThemeValueHardcodedIssue >> valueAssignment: anObject [
	valueAssignment := anObject
]
