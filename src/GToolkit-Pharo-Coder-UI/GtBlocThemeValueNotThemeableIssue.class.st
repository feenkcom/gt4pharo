Class {
	#name : #GtBlocThemeValueNotThemeableIssue,
	#superclass : #GtBlocThemeIssue,
	#instVars : [
		'themeableValue'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #accessing }
GtBlocThemeValueNotThemeableIssue >> description [
	^ 'Not a themeable value' format: { self themeableValue valueName }
]

{ #category : #accessing }
GtBlocThemeValueNotThemeableIssue >> themeableValue [
	^ themeableValue
]

{ #category : #accessing }
GtBlocThemeValueNotThemeableIssue >> themeableValue: anObject [
	themeableValue := anObject
]
