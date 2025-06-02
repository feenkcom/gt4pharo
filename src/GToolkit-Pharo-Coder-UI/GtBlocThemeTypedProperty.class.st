Class {
	#name : #GtBlocThemeTypedProperty,
	#superclass : #Object,
	#instVars : [
		'themeProperty',
		'issues'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty class >> detectTypeClassOf: aThemeProperty [
	(GtBlocThemeableColorProperty matchesThemeProperty: aThemeProperty)
		ifTrue: [ ^ GtBlocThemeableColorProperty ].

	(aThemeProperty propertyValue isKindOf: Color)
		ifTrue: [ ^ GtBlocThemeStaticColorType ].

	^ GtBlocThemeUnknownType
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty class >> detectTypeOf: aThemeableValue [
	^ (self detectTypeClassOf: aThemeableValue) new initializeForThemeProperty: aThemeableValue
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> constantAssignments [
	^ self themeProperty constantAssignments
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> createCoderViewModel: anAssignmentForCoder [
	| valueSourceCoder |
	
	valueSourceCoder := GtPharoSnippetCoder
		forSource: anAssignmentForCoder valueSourceCode.
	
	^ self
		createCoderViewModel: valueSourceCoder
		coderAssignment: anAssignmentForCoder.
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> createCoderViewModel: aCoderModel coderAssignment: aCoderAssignment [
	| valueSourceCoderViewModel|
	
	valueSourceCoderViewModel := aCoderModel asCoderViewModel.
	valueSourceCoderViewModel selfObject: self themeableValue subThemeModel subTheme.
	
	^ valueSourceCoderViewModel
]

{ #category : #accessing }
GtBlocThemeTypedProperty >> initializeForThemeProperty: aThemeProperty [
	themeProperty := aThemeProperty
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> isStaticType [
	^ false
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> isThemeableType [
	^ false
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> isUnknownType [
	^ false
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> issues [
	issues ifNotNil: [ :theIssues | ^ theIssues ].
	issues := Array streamContents: [ :s | self issuesOn: s ].
	^ issues
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> issuesOn: aStream [
	self isThemeableType
		ifFalse: [ aStream nextPut: (GtBlocThemeValueNotThemeableIssue new typedThemeProperty: self) ].
	
	self valueAssignments
		ifEmpty: [ aStream nextPut: (GtBlocThemeValueNotAssignedIssue new themeableValue: self themeProperty) ].
	
	self themeProperty amountOfValueAssignments > 1
		ifTrue: [ aStream nextPut: (GtBlocThemeTooManyAssignmentsIssue new typedThemeProperty: self) ]
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> printShortThemeableValue [
	^ self themeProperty printShortThemeableValue
]

{ #category : #accessing }
GtBlocThemeTypedProperty >> propertyName [
	^ self themeProperty propertyName
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> propertyValue [
	^ themeProperty propertyValue
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> subThemeModel [
	^ self themeProperty subThemeModel
]

{ #category : #accessing }
GtBlocThemeTypedProperty >> themeProperty [
	^ themeProperty
]

{ #category : #accessing }
GtBlocThemeTypedProperty >> themeableValue [
	^ themeProperty
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> transformAssignmentForCoder: aThemeableAssignment [
	^ aThemeableAssignment
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> valueAssignments [
	^ self themeProperty valueAssignments
]
