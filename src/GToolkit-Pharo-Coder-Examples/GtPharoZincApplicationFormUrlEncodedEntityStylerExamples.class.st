"
Exemplify {{gtClass:GtPharoZincApplicationFormUrlEncodedEntityStyler}}.
"
Class {
	#name : #GtPharoZincApplicationFormUrlEncodedEntityStylerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #'examples - source code' }
GtPharoZincApplicationFormUrlEncodedEntityStylerExamples >> compiledMethod [
	<gtExample>
	^ self class >> #sourceCode
]

{ #category : #'examples - source code' }
GtPharoZincApplicationFormUrlEncodedEntityStylerExamples >> sourceCode [
	<gtExample>
	^ ZnClient new
		url: 'https://example.com/auth/oauth/token' asZnUrl;
		entity:
			(ZnApplicationFormUrlEncodedEntity new
				at: 'grant_type' put: 'client_credentials';
				at: 'client_id' put: 'a client secret id';
				at: 'client_secret' put: 'client secret value';
				at: 'client_token' put: 'client secret token';
				yourself);
		accept: ZnMimeType applicationJson;
		yourself
]

{ #category : #'examples - styling' }
GtPharoZincApplicationFormUrlEncodedEntityStylerExamples >> styleId [
	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	
	aCoder := GtPharoSnippetCoder forSource: (ZnApplicationFormUrlEncodedEntity name, ' new ',
				'at: ''client_id'' put: ''a client secret id''') asRopedText.

	anAst := aCoder astAwait.
	aSourceText := aCoder sourceText copy unstyled.
	
	GtPharoZincApplicationFormUrlEncodedEntityStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText
		ast: anAst.
	
	aRedInterval := 1 to: 0.
	aSourceText
		findAttributeSuchThat: [ :eachAttribute | eachAttribute isKindOf: BrTextReplacingAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | aRedInterval := aStartPosition to: anEndPosition ].	

	self assert: aRedInterval equals: (61 to: 78).

	^ aSourceText
]

{ #category : #'examples - styling' }
GtPharoZincApplicationFormUrlEncodedEntityStylerExamples >> styleSecret [
	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	
	aCoder := GtPharoSnippetCoder forSource: (ZnApplicationFormUrlEncodedEntity name, ' new ',
				'at: ''client_secret'' put: ''a client secret value''') asRopedText.

	anAst := aCoder astAwait.
	aSourceText := aCoder sourceText copy unstyled.
	
	GtPharoZincApplicationFormUrlEncodedEntityStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText
		ast: anAst.
	
	aRedInterval := 1 to: 0.
	aSourceText
		findAttributeSuchThat: [ :eachAttribute | eachAttribute isKindOf: BrTextReplacingAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | aRedInterval := aStartPosition to: anEndPosition ].	

	self assert: aRedInterval equals: (65 to: 85).

	^ aSourceText
]

{ #category : #'examples - styling' }
GtPharoZincApplicationFormUrlEncodedEntityStylerExamples >> styleToken [
	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	
	aCoder := GtPharoSnippetCoder forSource: (ZnApplicationFormUrlEncodedEntity name, ' new ',
				'at: ''client_token'' put: ''a client secret token''') asRopedText.

	anAst := aCoder astAwait.
	aSourceText := aCoder sourceText copy unstyled.
	
	GtPharoZincApplicationFormUrlEncodedEntityStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText
		ast: anAst.
	
	aRedInterval := 1 to: 0.
	aSourceText
		findAttributeSuchThat: [ :eachAttribute | eachAttribute isKindOf: BrTextReplacingAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | aRedInterval := aStartPosition to: anEndPosition ].	

	self assert: aRedInterval equals: (64 to: 84).

	^ aSourceText
]
