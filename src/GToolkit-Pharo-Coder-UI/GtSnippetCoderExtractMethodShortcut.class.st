Class {
	#name : #GtSnippetCoderExtractMethodShortcut,
	#superclass : #GtSourceCoderExtractMethodShortcut,
	#category : #'GToolkit-Pharo-Coder-UI-Shortcuts'
}

{ #category : #evaluation }
GtSnippetCoderExtractMethodShortcut >> performOnEditor: aBrTextEditor element: aBrEditorElement coderViewModel: aSourceCoderViewModel dueTo: aShortcutEvent [		
	(GtExtractMethodFromSnippetController new sourceCoderViewModel: aSourceCoderViewModel) execute
]
