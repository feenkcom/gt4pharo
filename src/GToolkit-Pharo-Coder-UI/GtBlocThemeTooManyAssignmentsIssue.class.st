Class {
	#name : #GtBlocThemeTooManyAssignmentsIssue,
	#superclass : #GtBlocThemeIssue,
	#instVars : [
		'typedThemeProperty'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #'as yet unclassified' }
GtBlocThemeTooManyAssignmentsIssue >> canFixIt [
	^ false
]

{ #category : #accessing }
GtBlocThemeTooManyAssignmentsIssue >> description [
	^ 'Too many assignments, must be just one'
]

{ #category : #'as yet unclassified' }
GtBlocThemeTooManyAssignmentsIssue >> fixIt [
	^ nil
]

{ #category : #accessing }
GtBlocThemeTooManyAssignmentsIssue >> typedThemeProperty [
	^ typedThemeProperty
]

{ #category : #accessing }
GtBlocThemeTooManyAssignmentsIssue >> typedThemeProperty: anObject [
	typedThemeProperty := anObject
]
