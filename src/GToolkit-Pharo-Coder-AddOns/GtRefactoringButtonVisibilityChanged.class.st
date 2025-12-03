Class {
	#name : #GtRefactoringButtonVisibilityChanged,
	#superclass : #Announcement,
	#instVars : [
		'visible'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Base'
}

{ #category : #accessing }
GtRefactoringButtonVisibilityChanged >> visible [
	^ visible
]

{ #category : #accessing }
GtRefactoringButtonVisibilityChanged >> visible: aBoolean [
	visible := aBoolean
]
