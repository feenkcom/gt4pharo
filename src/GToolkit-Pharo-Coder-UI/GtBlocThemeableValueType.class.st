Class {
	#name : #GtBlocThemeableValueType,
	#superclass : #Object,
	#instVars : [
		'themeableValue'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #'as yet unclassified' }
GtBlocThemeableValueType class >> detectTypeClassOf: aThemeableValue [
	(aThemeableValue themeableValue isKindOf: BlThemeableColor)
		ifTrue: [ ^ GtBlocThemeableColorType ].
		
	(aThemeableValue themeableValue isKindOf: BlThemeableBackground)
		ifTrue: [ ^ GtBlocThemeableBackgroundType ].

	^ GtBlocThemeableUnknownType
]

{ #category : #'as yet unclassified' }
GtBlocThemeableValueType class >> detectTypeOf: aThemeableValue [
	^ (self detectTypeClassOf: aThemeableValue) new themeableValue: aThemeableValue
]

{ #category : #'as yet unclassified' }
GtBlocThemeableValueType >> isUnknownType [
	^ false
]

{ #category : #'as yet unclassified' }
GtBlocThemeableValueType >> simplifiedAssignmentAst: aThemeableAssignment [
	^ aThemeableAssignment valueAst
]

{ #category : #accessing }
GtBlocThemeableValueType >> themeableValue [
	^ themeableValue
]

{ #category : #accessing }
GtBlocThemeableValueType >> themeableValue: anObject [
	themeableValue := anObject
]

{ #category : #'as yet unclassified' }
GtBlocThemeableValueType >> validateSourceCode [
	"| pattern |
	valueAst isBlock
		ifFalse: [ self error: 'Must be a BlockClosure' ].

	pattern := GtPharoPatternParser
		parse: self generateColorBlockBodySourceCode
		startingAt: GtPharoParser startingStateForMethodSequence.

	(valueAst body match: pattern inContext: Dictionary new)
		ifFalse: [ self error: 'The format is wrong' ]"
]
