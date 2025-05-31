Class {
	#name : #GtBlocThemeValueNotAssignedIssue,
	#superclass : #GtBlocThemeIssue,
	#instVars : [
		'themeableValue'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #accessing }
GtBlocThemeValueNotAssignedIssue >> description [
	^ 'Value is not assigned' format: { self themeableValue valueName }
]

{ #category : #'as yet unclassified' }
GtBlocThemeValueNotAssignedIssue >> isSeriousIssue [
	^ true
]

{ #category : #accessing }
GtBlocThemeValueNotAssignedIssue >> themeableValue [
	^ themeableValue
]

{ #category : #accessing }
GtBlocThemeValueNotAssignedIssue >> themeableValue: anObject [
	themeableValue := anObject
]
