Class {
	#name : #GtPharoStylerExamples,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #examples }
GtPharoStylerExamples >> invalidSyntaxWithCascade [
	<gtExample>
	| aCoder anAst aSourceText aRedIntervals |
	
	aCoder := GtPharoSnippetCoder forSource: 'object := Object new
	isNil;
	notNil
Object new'.

	anAst := aCoder astSync.
	aSourceText := aCoder currentSourceText copy unstyled.
	
	GtPharoStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText
		ast: anAst.
	
	aRedIntervals := OrderedCollection new.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | (eachAttribute isKindOf: BlTextForegroundAttribute) and: [ eachAttribute paint = BlTheme default editor pharoErrorTokenForeground ] ]
		indicesDo: [ :aStartPosition :anEndPosition | aRedIntervals add: (aStartPosition to: anEndPosition) ].	

	self assert: aRedIntervals first equals: (38 to: 43).

	^ aSourceText
]

{ #category : #examples }
GtPharoStylerExamples >> temporariesAreLighterThanGlobalVariables [
	<gtExample>
	| aCoder anAst aSourceText lightIntervals |
	aCoder := GtPharoMethodCoder
			forMethod: GtPharoStylerExamples >> #invalidSyntaxWithCascade.
	anAst := aCoder astSync.
	aSourceText := aCoder currentSourceText copy unstyled.

	GtPharoStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText ast: anAst.

	lightIntervals := OrderedCollection new.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | 
			(eachAttribute isKindOf: BlFontWeightAttribute)
				and: [ eachAttribute weight = LogicalFont weightSemiBold ] ]
		indicesDo: [ :aStartPosition :anEndPosition | 
			| highlightedSourceText |
			"add highlightedSourceText just to make it easier to debug the example"
			highlightedSourceText := aSourceText copy.
			(highlightedSourceText from: aStartPosition to: anEndPosition)
				attribute: (BlTextUnderlineAttribute new color: Color orange).
			lightIntervals
				add: (aStartPosition to: anEndPosition) -> highlightedSourceText ].
	self assert: lightIntervals first key equals: (96 to: 114).

	^ aSourceText
]
