Class {
	#name : 'GtPharoStylerExamples',
	#superclass : 'Object',
	#category : 'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : 'examples' }
GtPharoStylerExamples >> invalidSyntaxWithCascade [
	<gtExample>
	| aCoder anAst aSourceText aRedIntervals |
	
	aCoder := GtPharoSnippetCoder forSource: 'object := Object new
	isNil;
	notNil
Object new'.

	anAst := aCoder astAwait.
	aSourceText := aCoder sourceText copy unstyled.
	
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
