Class {
	#name : #GtPharoDynamicHighlightStylerExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : 'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #accessing }
GtPharoDynamicHighlightStylerExamples >> keywordWithMultiplePartsHighlighted [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ (GtPharoSnippetCoder forSource: '#() do: [:x | ] displayingProgress: ''''')
					asCoderViewModel ].

	aScripter
		doStep: [ :s | 
			s
				action: [ :aCoderViewModel | aCoderViewModel moveCursorTo: 6 ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert keyword highlighted';
				satisfies: [ :aCoderEditor | 
					| highlights |
					highlights := OrderedCollection new.
					aCoderEditor text
						findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtPharoDynamicHighlightAttribute ]
						indicesDo: [ :aStart :anEnd | highlights add: (aStart to: anEnd) ].

					highlights notEmpty ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #accessing }
GtPharoDynamicHighlightStylerExamples >> keywordWithOnePartNotHighlighted [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ (GtPharoSnippetCoder forSource: '#() do: [:x | ]') asCoderViewModel ].

	aScripter
		doStep: [ :s | 
			s
				action: [ :aCoderViewModel | aCoderViewModel moveCursorTo: 6 ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert keyword not highlighted';
				satisfies: [ :aCoderEditor | 
					| highlights |
					highlights := OrderedCollection new.
					aCoderEditor text
						findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtPharoDynamicHighlightAttribute ]
						indicesDo: [ :aStart :anEnd | highlights add: (aStart to: anEnd) ].
					highlights isEmpty ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]

{ #category : #accessing }
GtPharoDynamicHighlightStylerExamples >> twoOccurrencesHighlighted [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ (GtPharoSnippetCoder forSource: 'var := var + 1') asCoderViewModel ].

	aScripter
		doStep: [ :s | 
			s
				action: [ :aCoderViewModel | aCoderViewModel moveCursorTo: 2 ];
				onModel ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert variable highlight attribute interval';
				satisfies: [ :aCoderEditor | 
					| highlights |
					highlights := OrderedCollection new.
					aCoderEditor text
						findAttributesSuchThat: [ :eachAttribute | eachAttribute class = GtPharoDynamicHighlightAttribute ]
						indicesDo: [ :aStart :anEnd | highlights add: (aStart to: anEnd) ].
					highlights notEmpty ];
				id: GtSourceCoderEditorId ].

	^ aScripter
]
