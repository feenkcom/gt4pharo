Class {
	#name : #GtBlocThemeableValueAssignment,
	#superclass : #Object,
	#instVars : [
		'subThemeClass',
		'valueName',
		'valueAst'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #accessing }
GtBlocThemeableValueAssignment >> subThemeClass [
	^ subThemeClass
]

{ #category : #accessing }
GtBlocThemeableValueAssignment >> subThemeClass: anObject [
	subThemeClass := anObject
]

{ #category : #accessing }
GtBlocThemeableValueAssignment >> valueAst [
	^ valueAst
]

{ #category : #accessing }
GtBlocThemeableValueAssignment >> valueAst: anObject [
	valueAst := anObject
]

{ #category : #accessing }
GtBlocThemeableValueAssignment >> valueName [
	^ valueName
]

{ #category : #accessing }
GtBlocThemeableValueAssignment >> valueName: anObject [
	valueName := anObject
]

{ #category : #'as yet unclassified' }
GtBlocThemeableValueAssignment >> valueSourceCode [
	^ valueAst source
]
