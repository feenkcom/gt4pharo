Class {
	#name : #GtSnippetCoderExtractMethodShortcut,
	#superclass : #GtSourceCoderExtractMethodShortcut,
	#category : 'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #evaluation }
GtSnippetCoderExtractMethodShortcut >> performOnEditor: aBrTextEditor element: aBrEditorElement coderViewModel: aSourceCoderViewModel dueTo: aShortcutEvent [
	(GtExtractMethodFromSnippetController new
		sourceCoderViewModel: aSourceCoderViewModel) executeIn: aBrEditorElement
]
