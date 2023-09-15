Class {
	#name : #GtRenameSelectorEditorAttribute,
	#superclass : #GtRenameEditorAttribute,
	#instVars : [
		'focusedIndex'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #accessing }
GtRenameSelectorEditorAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| editor |
	editor := super doAffect: aTBrTextEditorTextualPiece in: anEditorElement.
	editor
		when: BlFocusInEvent
		do: [ :event | renameAction focusedIndex: focusedIndex ].
	^ editor
]

{ #category : #accessing }
GtRenameSelectorEditorAttribute >> focusedIndex [
	^ focusedIndex
]

{ #category : #accessing }
GtRenameSelectorEditorAttribute >> focusedIndex: anObject [
	focusedIndex := anObject
]
