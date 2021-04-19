Class {
	#name : #GtPharoVariableHighlightStylerExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #accessing }
GtPharoVariableHighlightStylerExamples >> oneOccurrenceNotHighlighted [
	<gtExample>
	| aScripter |
	aScripter := self scripterForBlock: [ 
		(GtPharoSnippetCoder forSource: 'var := 42') asCoderViewModel ].
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
					eachAttribute class = GtPharoVariableHighlightAttribute ]
				indicesDo: [ :aStart :anEnd | highlights add: (aStart to: anEnd) ].
			highlights isEmpty ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.
	aScripter syncContinue.
	^ aScripter
]

{ #category : #accessing }
GtPharoVariableHighlightStylerExamples >> twoOccurrencesHighlighted [
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
					eachAttribute class = GtPharoVariableHighlightAttribute ]
				indicesDo: [ :aStart :anEnd | highlights add: (aStart to: anEnd) ].
			highlights notEmpty ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.
	aScripter syncContinue.
	^ aScripter
]
