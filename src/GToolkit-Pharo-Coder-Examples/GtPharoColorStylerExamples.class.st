"
I exemplify {{gtClass:GtPharoColorStyler}}.

"
Class {
	#name : #GtPharoColorStylerExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : 'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #'examples - styling' }
GtPharoColorStylerExamples >> colorFromColorRegistry [
	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	
	aCoder := GtPharoSnippetCoder forSource: 'Color brown' asRopedText.

	anAst := aCoder astSync.
	aSourceText := aCoder currentSourceText copy unstyled.
	
	GtPharoColorStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText
		ast: anAst.
	
	aRedInterval := 1 to: 0.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: BrTextAdornmentDynamicAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | aRedInterval := aStartPosition to: anEndPosition ].	

	self assert: aRedInterval equals: (11 to: 11).

	^ aSourceText
]

{ #category : #'examples - source code' }
GtPharoColorStylerExamples >> colorFromColorRegistrySourceCode [
	<gtExample>
	| aColor |
	aColor := Color lightBrown.
	self assert: (aColor isKindOf: Color).
	^ aColor
]

{ #category : #'examples - styling' }
GtPharoColorStylerExamples >> colorFromHexHighlighted [
	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	
	aCoder := GtPharoSnippetCoder forSource: 'Color fromHexString: #''5533ee''' asRopedText.

	anAst := aCoder astSync.
	aSourceText := aCoder currentSourceText copy unstyled.
	
	GtPharoColorStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText
		ast: anAst.
	
	aRedInterval := 1 to: 0.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: BrTextAdornmentDynamicAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | aRedInterval := aStartPosition to: anEndPosition ].	

	self assert: aRedInterval equals: (30 to: 30).

	^ aSourceText
]

{ #category : #'examples - source code' }
GtPharoColorStylerExamples >> colorFromHexStringSourceCode [
	<gtExample>
	| aColor |
	aColor := Color fromHexString: #'5533ee'.
	self assert: (aColor isKindOf: Color).
	^ aColor
]

{ #category : #'examples - source code' }
GtPharoColorStylerExamples >> colorFromRGBRangeSourceCode [
	<gtExample>
	| aColor |
	aColor := Color r: 100 g: 30 b: 200 range: 255.
	self assert: (aColor isKindOf: Color).
	^ aColor
]

{ #category : #'examples - styling' }
GtPharoColorStylerExamples >> colorRGBRangeHighlighted [
	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	
	aCoder := GtPharoSnippetCoder forSource: 'Color r: 100 g: 30 b: 200 range: 255' asRopedText.

	anAst := aCoder astSync.
	aSourceText := aCoder currentSourceText copy unstyled.
	
	GtPharoColorStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText
		ast: anAst.
	
	aRedInterval := 1 to: 0.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | eachAttribute isKindOf: BrTextAdornmentDynamicAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | aRedInterval := aStartPosition to: anEndPosition ].	

	self assert: aRedInterval equals: (36 to: 36).

	^ aSourceText
]
