Class {
	#name : #GtPharoHaltStylerExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #accessing }
GtPharoHaltStylerExamples >> haltHighlighted [
	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	
	aCoder := GtPharoSnippetCoder forSource: 'x := 42. self halt. y := 42' asRopedText.

	anAst := aCoder astAwait.
	aSourceText := aCoder sourceText copy unstyled.
	
	GtPharoHaltStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText
		ast: anAst.
	
	aRedInterval := 1 to: 0.
	aSourceText
		findAttributeSuchThat: [ :eachAttribute | (eachAttribute isKindOf: BlTextHighlightAttribute) and: [ eachAttribute paint = BrGlamorousColors errorBackgroundColor ] ]
		indicesDo: [ :aStartPosition :anEndPosition | aRedInterval := aStartPosition to: anEndPosition ].	

	self assert: aRedInterval equals: (15 to: 18).

	^ aSourceText
]
