Class {
	#name : #GtPharoColorStylerExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #accessing }
GtPharoColorStylerExamples >> colorFromHexHighlighted [
	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	
	aCoder := GtPharoSnippetCoder forSource: 'Color fromHexString: #''5533ee''' asRopedText.

	anAst := aCoder astAwait.
	aSourceText := aCoder sourceText copy unstyled.
	
	GtPharoColorStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText
		ast: anAst.
	
	aRedInterval := 1 to: 0.
	aSourceText
		findAttributeSuchThat: [ :eachAttribute | eachAttribute isKindOf: BrTextAdornmentDynamicAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | aRedInterval := aStartPosition to: anEndPosition ].	

	self assert: aRedInterval equals: (30 to: 30).

	^ aSourceText
]

{ #category : #accessing }
GtPharoColorStylerExamples >> colorRGBRangeHighlighted [
	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	
	aCoder := GtPharoSnippetCoder forSource: 'Color r: 100 g: 30 b: 200 range: 255' asRopedText.

	anAst := aCoder astAwait.
	aSourceText := aCoder sourceText copy unstyled.
	
	GtPharoColorStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText
		ast: anAst.
	
	aRedInterval := 1 to: 0.
	aSourceText
		findAttributeSuchThat: [ :eachAttribute | eachAttribute isKindOf: BrTextAdornmentDynamicAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | aRedInterval := aStartPosition to: anEndPosition ].	

	self assert: aRedInterval equals: (36 to: 36).

	^ aSourceText
]
