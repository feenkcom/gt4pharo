Class {
	#name : #GtBlocThemePropertyAssignment,
	#superclass : #Object,
	#instVars : [
		'subThemeClass',
		'valueAst',
		'subThemeSelector',
		'propertyName'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #'as yet unclassified' }
GtBlocThemePropertyAssignment >> asCoderAssignmentFor: aThemeValue [
	^ GtBlocThemeForCoderAssignment new
		subThemeClass: self subThemeClass;
		subThemeSelector: self subThemeSelector;
		valueName: self valueName;
		valueAst: self valueAst;
		originalAssignment: self;
		themeValue: aThemeValue;
		yourself
]

{ #category : #'as yet unclassified' }
GtBlocThemePropertyAssignment >> isConstantAssignment [
	^ false
]

{ #category : #accessing }
GtBlocThemePropertyAssignment >> propertyName [
	^ propertyName
]

{ #category : #accessing }
GtBlocThemePropertyAssignment >> subThemeClass [
	^ subThemeClass
]

{ #category : #accessing }
GtBlocThemePropertyAssignment >> subThemeClass: anObject [
	subThemeClass := anObject
]

{ #category : #'as yet unclassified' }
GtBlocThemePropertyAssignment >> subThemeMethod [
	^ subThemeClass >> subThemeSelector
]

{ #category : #accessing }
GtBlocThemePropertyAssignment >> subThemeSelector [
	^ subThemeSelector
]

{ #category : #accessing }
GtBlocThemePropertyAssignment >> subThemeSelector: anObject [
	subThemeSelector := anObject
]

{ #category : #accessing }
GtBlocThemePropertyAssignment >> valueAst [
	^ valueAst
]

{ #category : #accessing }
GtBlocThemePropertyAssignment >> valueAst: anObject [
	valueAst := anObject
]

{ #category : #accessing }
GtBlocThemePropertyAssignment >> valueName [
	^ propertyName
]

{ #category : #accessing }
GtBlocThemePropertyAssignment >> valueName: anObject [
	propertyName := anObject
]

{ #category : #'as yet unclassified' }
GtBlocThemePropertyAssignment >> valueSourceCode [
	^ self valueAst newSource
]
