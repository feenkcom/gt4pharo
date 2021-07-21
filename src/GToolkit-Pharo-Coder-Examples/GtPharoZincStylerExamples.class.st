Class {
	#name : #GtPharoZincStylerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #'examples - source code' }
GtPharoZincStylerExamples >> bearerSourceCode [
	<gtExample>
	^ ZnClient new
		url: 'https://example.com/api/info';
		setBearerAuthentication: 'secret token';
		yourself
]

{ #category : #'examples - styling' }
GtPharoZincStylerExamples >> styleBearer [
	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	
	aCoder := GtPharoSnippetCoder forSource: (ZnClient name, ' new ',
				'setBearerAuthentication: ''a secret token''') asRopedText.

	anAst := aCoder astAwait.
	aSourceText := aCoder sourceText copy unstyled.
	
	GtPharoZincStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText
		ast: anAst.
	
	aRedInterval := 1 to: 0.
	aSourceText
		findAttributeSuchThat: [ :eachAttribute | eachAttribute isKindOf: BrTextReplacingAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | aRedInterval := aStartPosition to: anEndPosition ].	

	self assert: aRedInterval equals: (40 to: 53).

	^ aSourceText
]

{ #category : #'examples - styling' }
GtPharoZincStylerExamples >> styleUsenamePassword [
	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	
	aCoder := GtPharoSnippetCoder forSource: (ZnClient name, ' new ',
				'username: ''joedoe'' password: ''a secret password''') asRopedText.

	anAst := aCoder astAwait.
	aSourceText := aCoder sourceText copy unstyled.
	
	GtPharoZincStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText
		ast: anAst.
	
	aRedInterval := 1 to: 0.
	aSourceText
		findAttributeSuchThat: [ :eachAttribute | eachAttribute isKindOf: BrTextReplacingAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | aRedInterval := aStartPosition to: anEndPosition ].	

	self assert: aRedInterval equals: (44 to: 60).

	^ aSourceText
]

{ #category : #'examples - source code' }
GtPharoZincStylerExamples >> usernameAndPasswordSourceCode [
	<gtExample>
	^ ZnClient new
		username: 'joedoe' password: 'secret password';
		yourself
]
