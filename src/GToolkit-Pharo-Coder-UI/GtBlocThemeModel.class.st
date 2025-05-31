Class {
	#name : #GtBlocThemeModel,
	#superclass : #Object,
	#instVars : [
		'subThemeModels',
		'theme',
		'themeClass'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #'as yet unclassified' }
GtBlocThemeModel >> initializeForTheme: aBlTheme [
	theme := aBlTheme.
	themeClass := aBlTheme class.
	
	subThemeModels := Array streamContents: [ :s |
		themeClass allInstVarNames do: [ :eachVar |
			| eachVarValue |
			eachVarValue := theme instVarNamed: eachVar.
			(eachVarValue isKindOf: BlSubTheme)
				ifTrue: [ s nextPut: (GtBlocSubThemeModel new subTheme: eachVarValue name: eachVar) ] ] ].
]

{ #category : #accessing }
GtBlocThemeModel >> subThemeModels [
	^ subThemeModels
]
