"
I exemplify {{gtClass:GtPharoNonBreakableSpaceStyler}}. 
"
Class {
	#name : #GtPharoNonBreakableSpaceStylerExamples,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #'examples - source code' }
GtPharoNonBreakableSpaceStylerExamples >> nbspSourceCode [
	<gtExample>
	^ 'I am a string with non-breakable space here: .' asRopedText
]

{ #category : #'examples - styling' }
GtPharoNonBreakableSpaceStylerExamples >> styleNonBreakableSpace [

	<gtExample>
	| aCoder anAst aSourceText allRedIntervals |
	aCoder := GtPharoSnippetCoder forSource:
		          (Object name , Character nbsp asString , 'new'
		           , Character nbsp asString , '') asRopedText.

	anAst := aCoder astSync.
	aSourceText := aCoder currentSourceText copy unstyled.

	GtPharoNonBreakableSpaceStyler new 
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText
		ast: anAst.

	allRedIntervals := OrderedCollection new.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | 
		eachAttribute isKindOf: BlTextDecorationAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | 
			allRedIntervals add: (aStartPosition to: anEndPosition) ].

	self assert: allRedIntervals size equals: 2.
	self assert: allRedIntervals asArray equals: { 7 to: 7. 11 to: 11}.
	
	^ aSourceText
]
