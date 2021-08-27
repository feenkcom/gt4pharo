Class {
	#name : 'GtPharoDynamicHighlightStylerExamples',
	#superclass : 'Object',
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : 'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : 'accessing' }
GtPharoDynamicHighlightStylerExamples >> keywordWithMultiplePartsHighlighted [
	<gtExample>
	| aScripter |
	aScripter := self scripterForBlock: [ 
		(GtPharoSnippetCoder forSource: '#() do: [:x | ] displayingProgress: ''''') asCoderViewModel ].
	aScripter do
		action: [ :aCoderViewModel | aCoderViewModel moveCursorTo: 6 ];
		onModel.
	aScripter wait forEmptySpaceTaskQueue.
	aScripter check
		label: 'Check keyword highlighted';
		satisfies: [ :aCoderEditor |
			| highlights |
			highlights := OrderedCollection new.
			aCoderEditor text
				findAttributeSuchThat: [ :eachAttribute | 
					eachAttribute class = GtPharoDynamicHighlightAttribute ]
				indicesDo: [ :aStart :anEnd | highlights add: (aStart to: anEnd) ].
			highlights notEmpty ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.
	aScripter syncContinue.
	^ aScripter
]

{ #category : 'accessing' }
GtPharoDynamicHighlightStylerExamples >> keywordWithOnePartNotHighlighted [
	<gtExample>
	| aScripter |
	aScripter := self scripterForBlock: [ 
		(GtPharoSnippetCoder forSource: '#() do: [:x | ]') asCoderViewModel ].
	aScripter do
		action: [ :aCoderViewModel | aCoderViewModel moveCursorTo: 6 ];
		onModel.
	aScripter wait forEmptySpaceTaskQueue.
	aScripter check
		label: 'Check keyword not highlighted';
		satisfies: [ :aCoderEditor |
			| highlights |
			highlights := OrderedCollection new.
			aCoderEditor text
				findAttributeSuchThat: [ :eachAttribute | 
					eachAttribute class = GtPharoDynamicHighlightAttribute ]
				indicesDo: [ :aStart :anEnd | highlights add: (aStart to: anEnd) ].
			highlights isEmpty ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.
	aScripter syncContinue.
	^ aScripter
]

{ #category : 'accessing' }
GtPharoDynamicHighlightStylerExamples >> oneOccurrenceNotHighlighted [
	<gtExample>
	| aScripter |
	aScripter := self scripterForBlock: [ 
		(GtPharoSnippetCoder forSource: 'var := 42') asCoderViewModel ].
	aScripter do
		action: [ :aCoderViewModel | aCoderViewModel moveCursorTo: 2 ];
		onModel.
	aScripter wait forEmptySpaceTaskQueue.
	aScripter check
		label: 'Check variable not highlighted';
		satisfies: [ :aCoderEditor |
			| highlights |
			highlights := OrderedCollection new.
			aCoderEditor text
				findAttributeSuchThat: [ :eachAttribute | 
					eachAttribute class = GtPharoDynamicHighlightAttribute ]
				indicesDo: [ :aStart :anEnd | highlights add: (aStart to: anEnd) ].
			highlights isEmpty ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.
	aScripter syncContinue.
	^ aScripter
]

{ #category : 'accessing' }
GtPharoDynamicHighlightStylerExamples >> twoOccurrencesHighlighted [
	<gtExample>
	| aScripter |
	aScripter := self scripterForBlock: [ 
		(GtPharoSnippetCoder forSource: 'var := var + 1') asCoderViewModel ].
	aScripter do
		action: [ :aCoderViewModel | aCoderViewModel moveCursorTo: 2 ];
		onModel.
	aScripter wait forEmptySpaceTaskQueue.
	aScripter check
		label: 'Check variable highlight attribute interval';
		satisfies: [ :aCoderEditor |
			| highlights |
			highlights := OrderedCollection new.
			aCoderEditor text
				findAttributeSuchThat: [ :eachAttribute | 
					eachAttribute class = GtPharoDynamicHighlightAttribute ]
				indicesDo: [ :aStart :anEnd | highlights add: (aStart to: anEnd) ].
			highlights notEmpty ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.
	aScripter syncContinue.
	^ aScripter
]
