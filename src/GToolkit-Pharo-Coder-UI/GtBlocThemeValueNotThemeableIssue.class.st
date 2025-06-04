Class {
	#name : #GtBlocThemeValueNotThemeableIssue,
	#superclass : #GtBlocThemeIssue,
	#instVars : [
		'typedThemeProperty'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #'as yet unclassified' }
GtBlocThemeValueNotThemeableIssue >> canFixIt [
	^ self typedThemeProperty isStaticType
]

{ #category : #accessing }
GtBlocThemeValueNotThemeableIssue >> description [
	^ 'Not a themeable value' format: { self typedThemeProperty propertyName }
]

{ #category : #'as yet unclassified' }
GtBlocThemeValueNotThemeableIssue >> fixIt [
	self typedThemeProperty isStaticType
		ifFalse: [ ^ nil ].
		
	^ self typedThemeProperty transformToThemeable
]

{ #category : #accessing }
GtBlocThemeValueNotThemeableIssue >> typedThemeProperty [
	^ typedThemeProperty
]

{ #category : #accessing }
GtBlocThemeValueNotThemeableIssue >> typedThemeProperty: anObject [
	typedThemeProperty := anObject
]
