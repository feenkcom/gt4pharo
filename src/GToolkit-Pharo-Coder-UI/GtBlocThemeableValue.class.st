Class {
	#name : #GtBlocThemeableValue,
	#superclass : #Object,
	#instVars : [
		'subThemeModel',
		'valueName',
		'valueAssignments',
		'themeableValue'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #accessing }
GtBlocThemeableValue >> subThemeModel [
	^ subThemeModel
]

{ #category : #accessing }
GtBlocThemeableValue >> subThemeModel: anObject [
	subThemeModel := anObject
]

{ #category : #accessing }
GtBlocThemeableValue >> themeableValue [
	^ themeableValue
]

{ #category : #accessing }
GtBlocThemeableValue >> themeableValue: anObject [
	themeableValue := anObject
]

{ #category : #'as yet unclassified' }
GtBlocThemeableValue >> validateSourceCode [
	
]

{ #category : #accessing }
GtBlocThemeableValue >> valueAssignments [
	^ valueAssignments
]

{ #category : #accessing }
GtBlocThemeableValue >> valueAssignments: anObject [
	valueAssignments := anObject asOrderedCollection
]

{ #category : #accessing }
GtBlocThemeableValue >> valueName [
	^ valueName
]

{ #category : #accessing }
GtBlocThemeableValue >> valueName: anObject [
	valueName := anObject
]
