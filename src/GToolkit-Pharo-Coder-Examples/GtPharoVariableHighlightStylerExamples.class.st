Class {
	#name : #GtPharoVariableHighlightStylerExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #accessing }
GtPharoVariableHighlightStylerExamples >> highlightVariable [
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
		value: [ :aCoderEditor |
			aCoderEditor text
				findAttributeSuchThat: [ :eachAttribute | 
					eachAttribute class = GtPharoVariableHighlightAttribute ]
				indicesDo: [ :aStart :anEnd | aStart to: anEnd ] ]
		equals: [ 1 to: 3 ];
		onChildNamed: GtPharoSourceCoder sourceEditorName.
	aScripter syncContinue.
	^ aScripter
]
