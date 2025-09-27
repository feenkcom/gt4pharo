"
I exemplify {{gtClass:GtPharoGlamorousIconStyler}}.
"
Class {
	#name : #GtPharoGlamorousIconStylerExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #'examples - source code' }
GtPharoGlamorousIconStylerExamples >> glamorousPixelIcon [
	<gtExample>
	| anIcon |
	anIcon := BrGlamorousIcons refresh.
	self assert: (anIcon isKindOf: Form).
	^ anIcon
]

{ #category : #'examples - source code' }
GtPharoGlamorousIconStylerExamples >> glamorousVectorIcon [
	<gtExample>
	| anIcon |
	anIcon := BrGlamorousVectorIcons refresh.
	self assert: (anIcon isKindOf: BrStencil).
	^ anIcon
]

{ #category : #'examples - styling' }
GtPharoGlamorousIconStylerExamples >> pixelRefreshIcon [

	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	aCoder := GtPharoSnippetCoder forSource:
		          (BrGlamorousVectorIcons name , ' ' , #refresh) asRopedText.

	anAst := aCoder astSync.
	aSourceText := aCoder currentSourceText copy unstyled.

	GtPharoGlamorousIconStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText ast: anAst.

	aRedInterval := 1 to: 0.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | 
			eachAttribute isKindOf: BrTextAdornmentDynamicAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | 
			aRedInterval := aStartPosition to: anEndPosition ].

	self assert: aRedInterval equals: (30 to: 30).

	^ aSourceText
]

{ #category : #'examples - styling' }
GtPharoGlamorousIconStylerExamples >> vectorRefreshIcon [

	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	aCoder := GtPharoSnippetCoder forSource:
		          (BrGlamorousVectorIcons name , ' ' , #refresh) asRopedText.

	anAst := aCoder astSync.
	aSourceText := aCoder currentSourceText copy unstyled.

	GtPharoGlamorousIconStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText ast: anAst.

	aRedInterval := 1 to: 0.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | 
			eachAttribute isKindOf: BrTextAdornmentDynamicAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | 
			aRedInterval := aStartPosition to: anEndPosition ].

	self assert: aRedInterval equals: (30 to: 30).

	^ aSourceText
]
