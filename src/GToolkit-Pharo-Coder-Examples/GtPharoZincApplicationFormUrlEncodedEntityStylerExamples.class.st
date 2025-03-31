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
				at: 'password' put: 'secret password';
				yourself);
		accept: ZnMimeType applicationJson;
		yourself
]

{ #category : #'examples - styling' }
GtPharoZincApplicationFormUrlEncodedEntityStylerExamples >> stylePassword [
	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	aCoder := GtPharoSnippetCoder forSource:
		          (ZnApplicationFormUrlEncodedEntity name , ' new '
		           , 'at: ''password'' put: ''a secret password''')
			          asRopedText.

	anAst := aCoder astSync.
	aSourceText := aCoder currentSourceText copy unstyled.

	GtPharoZincApplicationFormUrlEncodedEntityStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText ast: anAst.

	aRedInterval := 1 to: 0.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | 
		eachAttribute isKindOf: BrTextReplacingAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | 
			aRedInterval := aStartPosition to: anEndPosition ].

	self assert: aRedInterval equals: (60 to: 76).

	^ aSourceText
]

{ #category : #'examples - styling' }
GtPharoZincApplicationFormUrlEncodedEntityStylerExamples >> styleSecret [
	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	aCoder := GtPharoSnippetCoder forSource:
		          (ZnApplicationFormUrlEncodedEntity name , ' new '
		           , 'at: ''secret'' put: ''a secret value''')
			          asRopedText.

	anAst := aCoder astSync.
	aSourceText := aCoder currentSourceText copy unstyled.

	GtPharoZincApplicationFormUrlEncodedEntityStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText ast: anAst.

	aRedInterval := 1 to: 0.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | 
		eachAttribute isKindOf: BrTextReplacingAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | 
			aRedInterval := aStartPosition to: anEndPosition ].

	self assert: aRedInterval equals: (58 to: 71).

	^ aSourceText
]

{ #category : #'examples - styling' }
GtPharoZincApplicationFormUrlEncodedEntityStylerExamples >> styleToken [
	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	aCoder := GtPharoSnippetCoder forSource:
		          (ZnApplicationFormUrlEncodedEntity name , ' new '
		           , 'at: ''token'' put: ''a secret token''')
			          asRopedText.

	anAst := aCoder astSync.
	aSourceText := aCoder currentSourceText copy unstyled.

	GtPharoZincApplicationFormUrlEncodedEntityStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText ast: anAst.

	aRedInterval := 1 to: 0.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | 
		eachAttribute isKindOf: BrTextReplacingAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | 
			aRedInterval := aStartPosition to: anEndPosition ].

	self assert: aRedInterval equals: (57 to: 70).

	^ aSourceText
]
