"
I exemplify {{gtClass:GtPharoGlamorousColorStyler}}.
"
Class {
	#name : #GtPharoGlamorousColorStylerExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : 'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #'examples - styling' }
GtPharoGlamorousColorStylerExamples >> colorFromDefaultButtonBorderColor [

	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	aCoder := GtPharoSnippetCoder forSource:
		          (BrGlamorousColors name , ' ' , #defaultButtonBorderColor)
			          asRopedText.

	anAst := aCoder astSync.
	aSourceText := aCoder currentSourceText copy unstyled.

	GtPharoGlamorousColorStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText ast: anAst.

	aRedInterval := 1 to: 0.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | 
			eachAttribute isKindOf: BrTextAdornmentDynamicAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | 
			aRedInterval := aStartPosition to: anEndPosition ].

	self assert: aRedInterval equals: (42 to: 42).

	^ aSourceText
]

{ #category : #'examples - source code' }
GtPharoGlamorousColorStylerExamples >> glamorousColor [
	<gtExample>
	| aColor |
	aColor := BrGlamorousColors pressedButtonBorderColor.
	self assert: (aColor isKindOf: Color).
	^ aColor
]
