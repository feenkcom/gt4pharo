Class {
	#name : #GtSourceCoderEditorElementExamples,
	#superclass : #GtCoderByScripterExamples,
	#category : #'GToolkit-Pharo-Coder-Examples-UI'
}

{ #category : #'example - instance creation' }
GtSourceCoderEditorElementExamples >> editorForExampleMethodCoder [
	<gtExample>
	| aMethodCoder aMethodCoderUIModel anEditorElement scripter |
	aMethodCoder := GtPharoMethodCoderExamples new forExampleMethodCoder.
	aMethodCoderUIModel := aMethodCoder asCoderViewModel.
	self assert: aMethodCoderUIModel shouldAddOnsBeUpdated wait.
	scripter := BlScripter new.
	scripter
		element: (GtSourceCoderElement new textualCoderViewModel: aMethodCoderUIModel).
	anEditorElement := scripter elementWithoutParent.

	self assert: anEditorElement hasFocus not.
	self assert: anEditorElement padding equals: BlInsets empty.
	self assert: anEditorElement margin equals: BlInsets empty.
	self
		assert: anEditorElement text characters
		equals: aMethodCoder currentSourceText characters.

	^ anEditorElement
]

{ #category : #'example - instance creation' }
GtSourceCoderEditorElementExamples >> editorForInstrumentedMethodCoder [
	<gtExample>
	| aMethodCoder aMethodCoderUIModel anEditorElement scripter |
	aMethodCoder := GtPharoMethodCoderExamples new forInstrumentedMethodCoder.
	aMethodCoderUIModel := aMethodCoder asCoderViewModel.
	self assert: aMethodCoderUIModel shouldAddOnsBeUpdated wait.
	scripter := BlScripter new.
	scripter
		element: (GtSourceCoderElement new textualCoderViewModel: aMethodCoderUIModel).
	anEditorElement := scripter elementWithoutParent.

	self assert: anEditorElement hasFocus not.
	self assert: anEditorElement padding equals: BlInsets empty.
	self assert: anEditorElement margin equals: BlInsets empty.
	self
		assert: anEditorElement text characters
		equals: aMethodCoder currentSourceText characters.

	^ anEditorElement
]

{ #category : #'example - instance creation' }
GtSourceCoderEditorElementExamples >> editorForInstrumentedMethodCoderWithHighlighting [
	<gtExample>
	| aMethodCoder aMethodCoderUIModel anEditorElement scripter |
	aMethodCoder := GtPharoMethodCoderExamples new forInstrumentedMethodCoderWithHighlighting.
	aMethodCoderUIModel := aMethodCoder asCoderViewModel.
	self assert: aMethodCoderUIModel shouldAddOnsBeUpdated wait.
	scripter := BlScripter new.
	scripter
		element: (GtSourceCoderElement new textualCoderViewModel: aMethodCoderUIModel).
	anEditorElement := scripter elementWithoutParent.

	self assert: anEditorElement hasFocus not.
	self assert: anEditorElement padding equals: BlInsets empty.
	self assert: anEditorElement margin equals: BlInsets empty.
	self
		assert: anEditorElement text characters
		equals: aMethodCoder currentSourceText characters.

	^ anEditorElement
]

{ #category : #'example - instance creation' }
GtSourceCoderEditorElementExamples >> editorForSnippetCoder [
	<gtExample>
	| aSnippetCoder aSnippetCoderUIModel scripter anEditorElement |
	aSnippetCoder := GtPharoSnippetCoder new.
	aSnippetCoderUIModel := aSnippetCoder asCoderViewModel.

	self assert: aSnippetCoderUIModel shouldAddOnsBeUpdated wait.
	scripter := BlScripter new.
	scripter
		element: (GtSourceCoderElement new textualCoderViewModel: aSnippetCoderUIModel).
	anEditorElement := scripter elementWithoutParent.

	self assert: anEditorElement hasFocus not.
	self assert: anEditorElement padding equals: BlInsets empty.
	self assert: anEditorElement margin equals: BlInsets empty.
	self
		assert: anEditorElement text characters
		equals: aSnippetCoder currentSourceText characters.

	^ GtSourceCoderElement new textualCoderViewModel: aSnippetCoderUIModel
]
