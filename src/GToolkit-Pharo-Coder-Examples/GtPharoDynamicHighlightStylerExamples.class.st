Class {
	#name : #GtPharoDynamicHighlightStylerExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #accessing }
GtPharoDynamicHighlightStylerExamples >> keywordWithMultiplePartsHighlighted [
	<gtExample>
	<noTest>
	| aScripter |
	aScripter := self
			scripterForBlock: [ (GtPharoSnippetCoder forSource: '#() do: [:x | ] displayingProgress: ''''')
					asCoderViewModel ].

	aScripter do
		action: [ :aCoderViewModel | aCoderViewModel moveCursorTo: 6 ];
		onModel;
		play.

	aScripter assert
		label: 'Assert keyword highlighted';
		satisfies: [ :aCoderEditor | 
			| highlights |
			highlights := OrderedCollection new.
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtPharoDynamicHighlightAttribute ]
				indicesDo: [ :aStart :anEnd | highlights add: (aStart to: anEnd) ].

			highlights notEmpty ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #accessing }
GtPharoDynamicHighlightStylerExamples >> keywordWithOnePartNotHighlighted [
	<gtExample>
	<noTest>
	| aScripter |
	aScripter := self
			scripterForBlock: [ (GtPharoSnippetCoder forSource: '#() do: [:x | ]') asCoderViewModel ].

	aScripter do
		action: [ :aCoderViewModel | aCoderViewModel moveCursorTo: 6 ];
		onModel;
		play.

	aScripter assert
		label: 'Assert keyword not highlighted';
		satisfies: [ :aCoderEditor | 
			| highlights |
			highlights := OrderedCollection new.
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtPharoDynamicHighlightAttribute ]
				indicesDo: [ :aStart :anEnd | highlights add: (aStart to: anEnd) ].
			highlights isEmpty ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #accessing }
GtPharoDynamicHighlightStylerExamples >> oneOccurrenceNotHighlighted [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ (GtPharoSnippetCoder forSource: 'var := 42') asCoderViewModel ].

	aScripter do
		action: [ :aCoderViewModel | aCoderViewModel moveCursorTo: 2 ];
		onModel;
		play.

	aScripter assert
		label: 'Assert variable not highlighted';
		satisfies: [ :aCoderEditor | 
			| highlights |
			highlights := OrderedCollection new.
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtPharoDynamicHighlightAttribute ]
				indicesDo: [ :aStart :anEnd | highlights add: (aStart to: anEnd) ].
			highlights isEmpty ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]

{ #category : #accessing }
GtPharoDynamicHighlightStylerExamples >> twoOccurrencesHighlighted [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ (GtPharoSnippetCoder forSource: 'var := var + 1') asCoderViewModel ].

	aScripter do
		action: [ :aCoderViewModel | aCoderViewModel moveCursorTo: 2 ];
		onModel;
		play.

	aScripter assert
		label: 'Assert variable highlight attribute interval';
		satisfies: [ :aCoderEditor | 
			| highlights |
			highlights := OrderedCollection new.
			aCoderEditor text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtPharoDynamicHighlightAttribute ]
				indicesDo: [ :aStart :anEnd | highlights add: (aStart to: anEnd) ].
			highlights notEmpty ];
		id: GtSourceCoderEditorId;
		play.

	^ aScripter
]
