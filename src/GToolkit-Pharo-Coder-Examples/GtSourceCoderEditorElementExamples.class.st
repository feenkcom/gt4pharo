Class {
	#name : #GtSourceCoderEditorElementExamples,
	#superclass : #GtCoderByScripterExamples,
	#category : #'GToolkit-Pharo-Coder-Examples-UI'
}

{ #category : #'example - instance creation' }
GtSourceCoderEditorElementExamples >> editorForExampleMethodCoder [
	<gtExample>
	| aMethodCoder aMethodCoderUIModel anEditorElement |
	aMethodCoder := GtPharoMethodCoderExamples new forExampleMethodCoder.
	aMethodCoderUIModel := aMethodCoder asCoderViewModel.

	self assert: aMethodCoderUIModel shouldAddOnsBeUpdated wait.
	BlUseAsyncFeatures
		disableDuring: [ anEditorElement := GtSourceCoderEditorElement new
					textualCoderViewModel: aMethodCoderUIModel.
			aMethodCoderUIModel ensureAddOns ].
	self assert: aMethodCoderUIModel shouldAddOnsBeUpdated wait not.

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
	| aSnippetCoder aSnippetCoderUIModel anEditorElement |

	aSnippetCoder := GtPharoSnippetCoder new.
	aSnippetCoderUIModel := aSnippetCoder asCoderViewModel.

	self assert: aSnippetCoderUIModel shouldAddOnsBeUpdated wait.

	anEditorElement := GtSourceCoderEditorElement new textualCoderViewModel: aSnippetCoderUIModel.
	aSnippetCoderUIModel ensureAddOns.

	self assert: aSnippetCoderUIModel shouldAddOnsBeUpdated wait not.

	self assert: anEditorElement hasFocus not.
	self assert: anEditorElement padding equals: BlInsets empty.
	self assert: anEditorElement margin equals: BlInsets empty.
	self
		assert: anEditorElement text characters
		equals: aSnippetCoder currentSourceText characters.

	^ ValueHolder new contents: anEditorElement
]
