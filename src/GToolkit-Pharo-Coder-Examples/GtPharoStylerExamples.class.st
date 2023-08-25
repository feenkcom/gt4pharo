Class {
	#name : #GtPharoStylerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #examples }
GtPharoStylerExamples >> invalidSyntaxWithCascade [
	<gtExample>
	| aCoder anAst aSourceText aRedIntervals |
	
	aCoder := GtPharoSnippetCoder forSource: 'object := Object new
	isNil;
	notNil
Object new'.

	anAst := aCoder astAwait.
	aSourceText := aCoder currentSourceText copy unstyled.
	
	GtPharoStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText
		ast: anAst.
	
	aRedIntervals := OrderedCollection new.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | (eachAttribute isKindOf: BlTextForegroundAttribute) and: [ eachAttribute paint = Color red ] ]
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
	anAst := aCoder astAwait.
	aSourceText := aCoder currentSourceText copy unstyled.

	GtPharoStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText ast: anAst.

	lightIntervals := OrderedCollection new.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | 
			(eachAttribute isKindOf: BlTextForegroundAttribute)
				and: [ eachAttribute paint = Color blue twiceDarker ] ]
		indicesDo: [ :aStartPosition :anEndPosition | 
			| highlightedSourceText |
			highlightedSourceText := aSourceText copy.
			(highlightedSourceText from: aStartPosition to: anEndPosition)
				attribute: (BlTextUnderlineAttribute new color: Color orange).
			lightIntervals
				add: (aStartPosition to: anEndPosition) -> highlightedSourceText ].

	self assert: lightIntervals first key equals: (41 to: 47).

	^ aSourceText
]
