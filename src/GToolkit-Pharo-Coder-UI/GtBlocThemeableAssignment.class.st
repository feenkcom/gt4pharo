Class {
	#name : #GtBlocThemeableAssignment,
	#superclass : #Object,
	#instVars : [
		'subThemeClass',
		'valueName',
		'valueAst',
		'subThemeSelector'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #accessing }
GtBlocThemeableAssignment >> subThemeClass [
	^ subThemeClass
]

{ #category : #accessing }
GtBlocThemeableAssignment >> subThemeClass: anObject [
	subThemeClass := anObject
]

{ #category : #'as yet unclassified' }
GtBlocThemeableAssignment >> subThemeMethod [
	^ subThemeClass >> subThemeSelector
]

{ #category : #accessing }
GtBlocThemeableAssignment >> subThemeSelector [
	^ subThemeSelector
]

{ #category : #accessing }
GtBlocThemeableAssignment >> subThemeSelector: anObject [
	subThemeSelector := anObject
]

{ #category : #accessing }
GtBlocThemeableAssignment >> valueAst [
	^ valueAst
]

{ #category : #accessing }
GtBlocThemeableAssignment >> valueAst: anObject [
	valueAst := anObject
]

{ #category : #accessing }
GtBlocThemeableAssignment >> valueName [
	^ valueName
]

{ #category : #accessing }
GtBlocThemeableAssignment >> valueName: anObject [
	valueName := anObject
]
