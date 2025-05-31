Class {
	#name : #GtBlocThemeableColorValue,
	#superclass : #GtBlocThemeableValue,
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #'as yet unclassified' }
GtBlocThemeableColorValue >> generateColorBlockBodySourceCode [
	^ 'aTheme {1} constantAt: #{2}' format: { subThemeModel name . self name }
]

{ #category : #'as yet unclassified' }
GtBlocThemeableColorValue >> generateColorBlockSourceCode [
	^ '[ :aTheme | {1} ]' format: { self generateColorBlockBodySourceCode}
]

{ #category : #'as yet unclassified' }
GtBlocThemeableColorValue >> validateSourceCode [
	| pattern |
	valueAst isBlock
		ifFalse: [ self error: 'Must be a BlockClosure' ].

	pattern := GtPharoPatternParser
		parse: self generateColorBlockBodySourceCode
		startingAt: GtPharoParser startingStateForMethodSequence.

	(valueAst body match: pattern inContext: Dictionary new)
		ifFalse: [ self error: 'The format is wrong' ]
]
