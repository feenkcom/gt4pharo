Class {
	#name : #GtBlocThemeablePropertyHardcodedIssue,
	#superclass : #GtBlocThemeIssue,
	#instVars : [
		'typedThemeableProperty',
		'valueAssignment'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #'as yet unclassified' }
GtBlocThemeablePropertyHardcodedIssue >> canFixIt [
	(self typedThemeableProperty isThemeableType)
		ifFalse: [ ^ false ].
		
	(self typedThemeableProperty extractPropertyConstantAst: self valueAssignment)
		ifNil: [ ^ false ].
		
	^ true
]

{ #category : #accessing }
GtBlocThemeablePropertyHardcodedIssue >> description [
	^ 'Hardcoded value' format: { self typedThemeableProperty propertyName }
]

{ #category : #'as yet unclassified' }
GtBlocThemeablePropertyHardcodedIssue >> fixIt [
	| newThemeProperty subThemeModelCopy hardcodedValueAst newAssignment newConstantAssignment newValueAst |
	
	self typedThemeableProperty isThemeableType
		ifFalse: [ ^ nil ].

	hardcodedValueAst := self typedThemeableProperty
		extractPropertyConstantAst: self valueAssignment.
	
	subThemeModelCopy := self typedThemeableProperty subThemeModel copy.
	newConstantAssignment := subThemeModelCopy
		defineConstantNamed: self typedThemeableProperty propertyName
		valueAst: hardcodedValueAst
		inClass: self valueAssignment subThemeClass.
	
	newThemeProperty := self typedThemeableProperty themeProperty copy.

	newValueAst := RBParser parseExpression:
		self typedThemeableProperty generateThemeableInitializationSource.
	
	newAssignment := self valueAssignment copy.
	newAssignment valueAst: newValueAst.
	
	newThemeProperty
		replaceValueAssignment: self valueAssignment
		with: newAssignment.
		
	subThemeModelCopy
		replaceThemeProperty: self typedThemeableProperty themeProperty
		with: newThemeProperty.

	^ subThemeModelCopy generateThemeMethods
]

{ #category : #accessing }
GtBlocThemeablePropertyHardcodedIssue >> typedThemeableProperty [
	^ typedThemeableProperty
]

{ #category : #accessing }
GtBlocThemeablePropertyHardcodedIssue >> typedThemeableProperty: anObject [
	typedThemeableProperty := anObject
]

{ #category : #accessing }
GtBlocThemeablePropertyHardcodedIssue >> valueAssignment [
	^ valueAssignment
]

{ #category : #accessing }
GtBlocThemeablePropertyHardcodedIssue >> valueAssignment: anObject [
	valueAssignment := anObject
]
