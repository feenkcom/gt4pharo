"
I exemplify {{gtClass:GtPharoMethodPasswordStyler}}. 
"
Class {
	#name : #GtPharoMethodPasswordStylerExamples,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #'examples - source code' }
GtPharoMethodPasswordStylerExamples >> bearerSourceCode [

	<gtExample>
	^ ZnClient new
		  url: 'https://example.com/api/info';
		  setBearerAuthentication: 'secret token';
		  yourself
]

{ #category : #'examples - styling' }
GtPharoMethodPasswordStylerExamples >> styleBearer [

	<gtExample>
	| aCode |
	aCode := ZnClient name , ' new '
	         , 'setBearerAuthentication: ''a secret token'''.
	^ self styleSourceCode: aCode attributeInterval: (40 to: 53)
]

{ #category : #'examples - styling' }
GtPharoMethodPasswordStylerExamples >> stylePassword [

	<gtExample>
	| aCode |
	aCode := ZnClient name , ' new ' , 'password: ''a secret password'''.
	^ self styleSourceCode: aCode attributeInterval: (25 to: 41)
]

{ #category : #'examples - styling' }
GtPharoMethodPasswordStylerExamples >> styleSourceCode: aSourceString attributeInterval: anInterval [

	<gtExample>
	^ self
		styleSourceCode: aSourceString
		attributeIntervals: { anInterval }
]

{ #category : #'examples - styling' }
GtPharoMethodPasswordStylerExamples >> styleSourceCode: aSourceString attributeIntervals: aCollectionOfIntervals [

	<gtExample>
	| aCoder anAst aSourceText allIntervals |
	aCoder := GtPharoSnippetCoder forSource: aSourceString asRopedText.

	anAst := aCoder astSync.
	aSourceText := aCoder currentSourceText copy unstyled.

	GtPharoMethodPasswordStyler new
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText ast: anAst.

	allIntervals := OrderedCollection new.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | 
			eachAttribute isKindOf: BrTextReplacingAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | 
			allIntervals add: (aStartPosition to: anEndPosition) ].

	self
		assert: allIntervals asArray
		equals: aCollectionOfIntervals asArray.

	^ aSourceText
]

{ #category : #accessing }
GtPharoMethodPasswordStylerExamples >> styleUsenamePassword [

	<gtExample>
	| aCode |
	aCode := ZnClient name , ' new ' ,
	         'username: ''joedoe'' password: ''a secret password''; yourself'.
	^ self styleSourceCode: aCode attributeInterval: (44 to: 60)
]

{ #category : #'examples - source code' }
GtPharoMethodPasswordStylerExamples >> usernameAndPasswordSourceCode [
	<gtExample>
	^ ZnClient new
		username: 'joedoe' password: 'secret password';
		yourself
]
